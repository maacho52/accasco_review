class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :scores

  enum sex: { man: 0, woman: 1, another: 2 }
  enum part: { lead: 0, top: 1, chorus2: 2, chorus3: 3, chorus4: 4, bass: 5, voicepercussion: 6 }

  #def self.guest
   # find_or_create_by!(email: 'guest@example.com') do |user|
    #  user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  #  end
  #end
  
  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.nickname = 'サンプル'
      user.birthday = '2000-01-01'
    end
  end  
end