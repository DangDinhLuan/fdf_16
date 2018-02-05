class Product < ApplicationRecord
  belongs_to :category
  has_many :items
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :category_id, presence: true
  validates :title, presence: true, length: {maximum: Settings.validates.title.length.maximum}
  validates :description, presence: true
  mount_uploader :image, ImageUploader
  validates :image, presence: true, allow_nil: true
  validates :price, presence: true
  validates :quantity, presence: true

  scope :recent, ->{order created_at: :desc}
  scope :top_rated, ->{order avg_rate: :desc}
  scope :related, -> product{where "category_id = ? and id <> ?", product.category_id, product.id}
  scope :filter, -> (category_id) {where(category_id: category_id)}
  scope :price_between, -> prices{where prices}
  scope :rating_in, ->ratings{where ratings}
  scope :order_by_price, ->order_type{order price: order_type}
  scope :filter_by_category, ->category_type{joins(:category).where("categories.category_type = ?", category_type)}
  scope :search, ->key_word{where "title like '%#{key_word}%' or description like '%#{key_word}%'"}
  
  
  def excerp
    self.description.truncate Settings.product.description.excerp, separator: /\s/
  end
  
  def update_ratings
    self.avg_rate = self.ratings.average :point
    self.rates = self.ratings.count :point
    self.save
  end

  def rated_by user
    if user && rated = self.ratings.where("user_id = ?", user.id).first
      rated.point
    end
  end

  class << self
    def filter_by_params filtering_params
      results = self.where nil
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
