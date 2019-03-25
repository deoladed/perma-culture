# frozen_string_literal: true
require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  geocoded_by :address
  after_validation :geocode
  
  before_create :grab_image
  after_create :avatar_mini
  after_create :welcome_send
  after_create :welcome_chat

  has_one_attached :avatar
  has_one_attached :avatar_mini
  has_one_attached :avatar_medium
  has_one_attached :avatar_big

  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :posts, foreign_key: 'writter_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :conversations, foreign_key: :sender_id
  
  validates :user_name, 
  presence: true, 
  uniqueness: true,
  length: { in: 3..25 }

  validates :email, 
  presence: true, 
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Veuillez entrer un email valide"}

  def grab_image
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.png')), filename: "image-user-#{self.user_name}.png")
  end
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def welcome_chat
    WelcomeChatJob.set(wait: 5.seconds).perform_later(self)
  end

  def dont_already_like?(likeable)
    self.likes.find_by(likeable: likeable).nil?
  end

  def self.search(search)
    if search
      where('user_name ILIKE ?', "%#{search}%")
    else
      all
    end
  end

  def online
    self.update(is_online: true)
  end

  def offline
    self.update(is_online: false)
  end

  def is(user)
    self.id == user.id
  end

  def doesnt_have_an_address
    self.longitude.nil? || self.latitude.nil?
  end

  def avatar_mini
    if self.avatar.attached?
      return self.avatar.variant(combine_options: [
        [:resize, "64x64^"],
        [:gravity, "center"],
        [:crop, "64x64+0+0"]
      ])
    end
  #   # ImageVariantsJob.perform_later(self)
  #   path = Rails.root.join('tmp', self.avatar.blob.filename.to_s).to_s

  #   File.open(path, 'wb') do |file|
  #     file.write(self.avatar.blob.download)
  #   end

  #   customize_image = MiniMagick::Image.open(path)
  #   customize_image.crop("64x64+0+0")
  #   # customize_image.write("avatar_mini-#{self.user_name}.jpg")

  #   # customize_image = File.open(path).variant(combine_options: [
  #   #   [:resize, "64x64^"],
  #   #   [:gravity, "center"],
  #   #   [:crop, "64x64+0+0"]
  #   # ])


  #   # file = File.open(customize_image.path)
  #   # filename = Time.zone.now.strftime("%Y%m%d%H%M%S") + self.avatar.blob.filename.to_s
  #   self.avatar_mini.attach(io: File.open(customize_image.path), filename: "image_mini-user-#{self.user_name}.png")
  #   p 'avatar-mini created'

  # #   path = Rails.application.routes.url_helpers.rails_blob_path(self.avatar, only_path: true)
      
  # #   customize_image = MiniMagick::Image.open(path)
  #   # customize_image.variant(combine_options: [
  #   #   [:resize, "64x64^"],
  #   #   [:gravity, "center"],
  #   #   [:crop, "64x64+0+0"]
  #   # ])

  # #   self.avatar_mini.attach.(io: File.open(customize_image.path, filename: 'image.png'))
  end

  def avatar_medium
    # variation = ActiveStorage::Variation.new(resize_to_fit: [64, 64], crop: true)

    # self.avatar.open do |input|
    #   variation.transform(input, format: "png") do |output|
    #     self.avatar_medium.attach \
    #     io: output,
    #     filename: "#{self.avatar.filename.base}.png",
    #     content_type: "image/png"
    #   end
    # end


    if self.avatar.attached?
      return self.avatar.variant(combine_options: [
        [:resize, "210x210^"],
        [:gravity, "center"],
        [:crop, "210x210+0+0"]
      ])
    end
  end

  def avatar_big
    if self.avatar.attached?
      return self.avatar.variant(combine_options: [
        [:resize, "300x300^"],
        [:gravity, "center"],
        [:crop, "300x300+0+0"]
      ])
    end
  end
end
