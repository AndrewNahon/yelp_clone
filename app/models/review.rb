class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business

  validates_presence_of :user, :business, :rating, :body
  validates :user_id, :uniqueness => { :scope => :business_id }

  def self.recent_reviews 
    order(created_at: :desc).first(10)
  end

end