class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :content, presence: true

  has_many :comments, dependent: :destroy
end
