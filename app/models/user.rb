class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :scores

  enum sex: { man: '0', woman: '1', another: '2' }
  enum part: { lead: '0', top: '1', chorus2: '2', chorus3: '3', chorus4: '4', bass: '5', voicepercussion: '6' }

  #def self.guest
   # find_or_create_by!(email: 'guest@example.com') do |user|
    #  user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  #  end
  #end
  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.nickname = 'ゲストユーザー'
      user.birthday = '2000-01-01'
    end
  end

  def get_image(width, height)
    #binding.pry
   if !profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    #binding.pry
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   else
    profile_image.variant(resize_to_limit: [width, height]).processed
   end
  end
end