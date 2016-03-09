class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  enum sex: %w(unknown male female)
  enum role: %w(user moderator admin)

  has_many :posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :albums, as: :owner, dependent: :destroy

  before_validation :set_current_language, on: :create
  before_validation :strip_username

  validates :username,
            presence: true,
            length: { minimum: 3, maximum: 30 },
            uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_-]*\z/ }
   #validates :username, exclusion: Settings.exsules.users.username_blacklist
  validates :language, inclusion: %w(en sv no) # TODO: Load from file
  validates :first_name,
            presence: true,
            length: { maximum: 32 },
            format: { with: /\A[^;]+\z/ }
  validates :last_name,
            presence: true,
            length: { maximum: 32 },
            format: { with: /\A[^;]+\z/ }
  validates :email,
            presence: true,
            format: { with: /\A\s*((?!\.)(?:[-a-z0-9+_]|\.(?![\.@])){1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i }

  before_save :update_username_lower
  before_save :strip_downcase_email

  after_create :send_welcome_email

  friendly_id :slug_candidates, use: :slugged

  searchkick match: :word_start, suggest: [:full_name], callbacks: :async

  def search_data
    {
      id: id,
      username: username,
      first_name: first_name,
      last_name: last_name,
      full_name: "#{first_name} #{last_name}"
    }
  end

  def slug_candidates
    [
      :username,
      [:first_name, :last_name],
      [:last_name, :first_name],
      [:first_name, :last_name, :username]
    ]
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_welcome_email
    #UserMailer.welcome(self).deliver_later
  end

  def strip_username
    self.username = username.strip unless self.username.nil?
  end

  def update_username_lower
    self.username_lower = username.downcase
  end

  def strip_downcase_email
    if self.email # For facebook later on
      self.email = self.email.strip
      self.email = self.email.downcase
    end
  end

  def set_current_language
    self.language = I18n.locale.to_s if self.language.blank?
  end

  def self.find_by_username_or_email(username_or_email)
    if username_or_email.include?('@')
      find_by_email(username_or_email)
    else
      find_by_username(username_or_email)
    end
  end

  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  def self.find_by_username(username)
    find_by(username_lower: username.downcase)
  end

  private

end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  email                  :string
#  tokens                 :json
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string           not null
#  username_lower         :string           not null
#  initial_setup          :boolean          default(FALSE)
#  first_name             :string           not null
#  last_name              :string           not null
#  sex                    :integer          default("unknown")
#  location               :string
#  bio                    :string(128)
#  birthday               :date
#  posts_count            :integer          default(0)
#  role                   :integer          default("user")
#  disable_mail           :boolean          default(FALSE)
#  preferences            :jsonb            not null
#  language               :string
#  slug                   :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email)
#  index_users_on_preferences           (preferences)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
