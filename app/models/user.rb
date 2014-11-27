# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation,
                  :password_reset_token, :password_reset_sent_at

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token


  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6}
  validates :password_confirmation, presence: true

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
    UserMailer.follow_notification(self, other_user).deliver
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def send_password_reset
    generate_secure_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.password = self.password_confirmation = ('a'..'z').to_a.shuffle.join
    save!
    UserMailer.password_reset(self).deliver
  end

  private
  def generate_secure_token(column)
    if User.exists?(column => self[column])
    self[column] = SecureRandom.urlsafe_base64
    end
  end

  def create_remember_token
    generate_secure_token(:remember_token)
  end

end
