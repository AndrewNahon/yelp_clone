class Business < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :name, :description, :city
  validates_uniqueness_of :name

  def rating
    return nil if reviews.count == 0
    rating = (reviews.reduce(0) { |sum, review | sum + review.rating } / reviews.count.to_f).round(1)
    format_rating(rating)
  end

  def has_no_review_by?(user)
    !reviews.map(&:user).include?(user)
  end

  def has_been_reviewed?
    reviews.count > 0
  end
end

def format_rating(n)
  n.to_int == n ? n.to_int : n
end