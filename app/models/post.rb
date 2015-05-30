class Post < ActiveRecord::Base

  include PgSearch

  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :votes, as: :votable
  has_many :user_votes, through: :votes, source: :user

  def voted_by?(user)
    self.user_votes.include? user
  end


  # multisearchable against: [:title, :content]

  pg_search_scope :search_by_title_or_content, against: [:title, :content], using: { tsearch: { prefix: true } }
  pg_search_scope :search_by_content, against: [:content]
  pg_search_scope :search_by_title, against: [:title]
  pg_search_scope :search_by_author,
    associated_against: { user: :name },
    using: { tsearch: { prefix: true } }
end
