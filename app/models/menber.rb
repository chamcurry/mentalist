class Menber < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :comments,dependent: :destroy
  validates :first_name,:last_name,presence: true
  def full_name
      self.first_name + " " + self.last_name
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'user.jpg')
    end
   profile_image
  end
      # ゲストユーザー
  def self.guest_user
    find_or_create_by!(email: 'guest_user@example.com') do |guest|
      guest.password = SecureRandom.urlsafe_base64
      # guest.password_confirmation = user.password
    end
  end
end