class Score < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  belongs_to :site

  has_one_attached :image

    #score_arrangesのリレーション記載
  has_many :score_arranges, dependent: :destroy
  has_many :arranges, through: :score_arranges

  enum member: { three: 0, four: 1, five: 2, six: 3, seven_or_more: 4, boys: 5, girls: 6 }
  enum difficulty: { introduction: 0, biginner: 1, intermediate: 2, advanced: 3, superlative: 4 }

  def save_arrange(arrange_ids)
    arrange_ids.each do |arrange_id|
      ScoreArrange.create(score_id: id, arrange_id: arrange_id)
    end
  end


  def self.search(search)#self.はScore.を意味する
    if search != ""
      Score.eager_load(:arranges, :site).where('scores.artist LIKE(?) OR scores.name LIKE(?) OR scores.difficulty LIKE(?) OR scores.member LIKE(?) OR sites.name LIKE(?) OR arranges.body LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    #検索とartist,name,site.name,arrange.bodyの部分一致を表示。
    else
      Score.all
    end
  end

  def get_image(width, height)
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
