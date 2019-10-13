if Rails.env.production?
  Cloudinary.config do |config|
    config.secure = true
    config.cdn_subdomain = false
    config.private_cdn = false
  end
end