class Score < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :arranges
  belongs_to :user
  belongs_to :site

    #arrange_tagのリレーション記載
  has_many :arrange_tags, dependent: :destroy
  has_many :arrange, through: :arrange_tags

  enum member: { three: 0, four: 1, five: 2, six: 3, seven_or_more: 4, boys: 5, girls: 6 }
  enum difficulty: { introduction: 0, biginner: 1, intermediate: 2, advanced: 3, superlative: 4 }

  #def save_arrange(sent_arrranges)
  # アレンジが存在していれば、アレンジの名前を配列として全て取得
    #current_arranges = self.arranges.pluck(:name) unless self.arranges.nil?
    # 現在取得したアレンジから送られてきたアレンジを除いてoldarrangeとする
    #old_arranges = current_arranges - sent_arranges
    # 送信されてきたアレンジから現在存在するアレンジを除いたアレンジをnewとする
    #new_arranges = sent_arranges - current_arranges

     # 古いアレンジを消す
    #old_arranges.each do |old|
      #self.arranges.delete　Arrange.find_by(name: old)
    #end

    # 新しいアレンジを保存
    #new_arranges.each do |new|
      #new_arrange_tag = Arrange.find_or_create_by(name: new)
      #self.arranges << new_arrange_tag
    #end
  #end
  
  def self.search(search)
    if search != ""
      Score.joins(:arrange, :site).where('artist LIKE(?) OR name LIKE(?) OR site.name LIKE(?) OR arrange.body', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Score.all
    end
  end
end
