class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    unless params[:image_name]
      @user.image_name = "profile.png"
    end
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    
    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした'
      render :edit
    end
    
    if params[:image]
    @user.image_name = "#{@user.id}.jpg"  
    image = params[:image]
    File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image_name, :password, :password_confirmation, :introduction)
  end
end
