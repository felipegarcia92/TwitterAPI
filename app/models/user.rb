require 'digest/sha1'

class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: EMAIL_REGEX }

  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :session_token, uniqueness: true

  attr_accessor :password

  before_create :set_session_token
  before_save :encrypt_password

  has_many :tweets, through: :user_like_tweets, class_name: 'Tweet'

  #CarrierWave Uploader
  mount_uploader :avatar, AvatarUploader

  def encrypt_password
      self.encrypted_password = Digest::SHA1.hexdigest(password) if password.present?
  end

  def set_session_token
    return if session_token.present?
    self.session_token = generate_session_token
  end

  private

  def generate_session_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(session_token: token)
    end
  end

end
