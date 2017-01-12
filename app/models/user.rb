class User < ActiveRecord::Base
  include Commentable

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :goals
  has_many :authored_comments, class_name: "Comment", foreign_key: :author_id
  has_many :cheers_given, class_name: "Cheers"

  def self.find_by_username_and_password(username, password)
    user = User.find_by_username(username)
    user && user.is_password?(password) ? user : nil
  end

  def self.top_users
    query = <<-SQL
      SELECT
        users.*, COUNT(cheers.id) AS cheers_count
      FROM
        users
      JOIN
        goals ON goals.user_id = users.id
      JOIN
        cheers ON cheers.goal_id = cheers.id
      GROUP BY
        users.id
      ORDER BY
        COUNT(cheers.id) DESC
      LIMIT
        10
    SQL

    User.find_by_sql(query)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
    self.save
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def has_remaining_cheers?
    self.cheers_count > 0
  end

  def has_cheersed_goal?(goal)
    !!Cheer.find_by(user: self, goal: goal)
  end

  def cheers_goal
    self.cheers_count -= 1
    self.save
  end

  def uncheers_goal
    self.cheers_count += 1
    self.save
  end

  private
  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
