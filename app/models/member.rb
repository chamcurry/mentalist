class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
        # Twitter API認証用
         :omniauthable,omniauth_providers: [:twitter]

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
      file_path = Rails.root.join("app/assets/images/user.jpg")
      profile_image.attach(io: File.open(file_path), filename: "user.jpg",content_type: "image/jpg")
    end
   profile_image
  end

  def self.find_for_oauth(auth)
    member = Member.find_by(uid: auth.uid, provider: auth.provider)

    member ||= Member.create!(
      uid: auth.uid,
      provider: auth.provider,
      first_name: auth.info,
      last_name: auth.info,
      # name: auth[:info][:name],
      email: Member.dummy_email(auth),
      password: Devise.friendly_token[0,20]
      )
    member
  end

  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}example.com"
  end
end
