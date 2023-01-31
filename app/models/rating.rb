class Rating < ApplicationRecord
  after_save :update_rating
  belongs_to :post

  def update_rating
    self.post.update(rating_average: self.post.ratings.average(:num))
  end
end
