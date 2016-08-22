class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  def content_type_whitelist
    /image\//
  end

  version :small do
    process resize_to_fit: [720, 720]
  end
end