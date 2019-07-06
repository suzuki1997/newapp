class User < ApplicationRecord
  has_many :posts,dependent: :destroy
  attr_accessor :remember_token
  before_save{self.email = email.downcase}
  mount_uploader :picture,PictureUploader
  validates :name,presence: true,length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false }
  has_secure_password
  validates :password,presence: true,length: {minimum: 6},allow_nil: true
  validate :picture_size
  
  #引数で渡されたものをハッシュ化する
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #新しいトークンを作成
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    #新しく作成したトークンをその人のrememberトークンとして設定
    self.remember_token = User.new_token
    #作成したremember_tokenをハッシュ化し、remeber_digestに保存する
    update_attribute(:remember_digest,User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  
  def forget
    update_attribute(:remember_digest,nil)
  end 
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
  
end

