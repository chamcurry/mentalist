class Menber < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image
  has_many :posts
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy

 def self.guest
   find_or_create_by!(email: 'guest_user@example.com') do |guest|
    guest.password = SecureRandom.urlsafe_base64
    # guest.password_confirmation = user.password
  end
 end
end