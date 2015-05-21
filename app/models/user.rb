class User < ActiveRecord::Base
  # carrierwave
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :timeoutable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates :name, presence: true
  # validates :avatar, presence: true
  validates_integrity_of :avatar
  validates_processing_of :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :votes
  has_many :post_votes, through: :votes, source: :post

  enum role: [:guest, :moderator]

  # Omniauth
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?
        if identity.provider == "twitter"
            user = User.new(
              name: auth.info.name,
              email: email ? email : "update@me.com",
              remote_avatar_url: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
          else
            user = User.new(
              name: auth.info.name,
              email: email ? email : "update@me.com",
              remote_avatar_url: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
          end
        user.save!
      end
    end

    # Associate the identity with the user if needed
    unless identity.user == user
      identity.user = user
      identity.save!
    end
    user
  end

end
