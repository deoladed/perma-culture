class ImageVariantsJob < ApplicationJob
  queue_as :default

  def perform(user)

    path = Rails.root.join('tmp', user.avatar.blob.filename.to_s).to_s

    File.open(path, 'wb') do |file|
      file.write(user.avatar.blob.download)
    end

    customize_image = MiniMagick::Image.open(path)
    customize_image.crop("64x64+0+0")
    # customize_image.write("avatar_mini-#{user.user_name}.jpg")

    # customize_image = File.open(path).variant(combine_options: [
    #   [:resize, "64x64^"],
    #   [:gravity, "center"],
    #   [:crop, "64x64+0+0"]
    # ])


    # file = File.open(customize_image.path)
    # filename = Time.zone.now.strftime("%Y%m%d%H%M%S") + user.avatar.blob.filename.to_s
    user.avatar_mini.attach(io: File.open(customize_image.path), filename: "image_mini-user-#{user.user_name}.png")
    p 'avatar-mini created'

  #   path = Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true)
      
  #   customize_image = MiniMagick::Image.open(path)
    # customize_image.variant(combine_options: [
    #   [:resize, "64x64^"],
    #   [:gravity, "center"],
    #   [:crop, "64x64+0+0"]
    # ])

  #   user.avatar_mini.attach.(io: File.open(customize_image.path, filename: 'image.png'))

  end
end
