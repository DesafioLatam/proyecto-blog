class User < ActiveRecord::Base
  #carrierwave
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


 # before_save :default_role

  validates :name, presence: true
  # validates :avatar, presence: true
  validates_integrity_of :avatar
  validates_processing_of :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: [:guest, :moderator]

=begin
  def default_role
    self.role ||= 0
  end
=end

end
