# class User < ActiveRecord::Base
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :trackable, :validatable
#   has_many :comments
#   mount_uploader :avatar, AvatarUploader
# end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:instagram]
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{auth.uid}@gmail.com"
      user.username = auth.info[:nickname]
      user.provider = auth.provider
      user.uid = auth.uid
      user.profile_image = auth.info[:image]
      user.password = Devise.friendly_token[0,20]
    end
  end
  has_many :comments
  mount_uploader :avatar, AvatarUploader
end

# <OmniAuth::AuthHash expires=false token="2734684683.ed634b0.5fcff3a6ff4e4fd5965b97fb6ac0dec9">extra=
#<OmniAuth::AuthHash raw_info=
#<OmniAuth::AuthHash bio="" full_name="Tranthuc" id="2734684683"
# profile_picture="https://igcdn-photos-e-a.akamaihd.net/hphotos-ak-xft1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg"
# username="tranthuc6685" website="">> info=#<OmniAuth::AuthHash::InfoHash bio="" email=nil
# image="https://igcdn-photos-e-a.akamaihd.net/hphotos-ak-xft1/t51.2885-19/11906329_960233084022564_1448528159_a.jpg" name="Tranthuc" nickname="tranthuc6685" website=""> provider="instagram" uid="2734684683">
