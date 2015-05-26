class Comment < ActiveRecord::Base

  validates :content, presence: true

  belongs_to :post
  belongs_to :user

  has_many :votes, as: :votable
  has_many :user_votes, through: :votes, source: :user

  def voted_by?(user)
    self.user_votes.include? user
  end
end
