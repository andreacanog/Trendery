# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_session_token  (session_token) UNIQUE
#
class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true, length: { in: 3..30 }

    validates :email, 
    presence: true,
    uniqueness: true, 
    length: { in: 3..255 }, 
    format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { in: 6..255 }, allow_nil: true

    has_many :orders, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :products, through: :orders

    ## need to come back and uncomment after I finish core functionality for the app 
    # has_one :profile, dependent: :destroy
    # has_many :reviews, dependent: :destroy
  
    before_validation :ensure_session_token
  

    def self.find_by_credentials(credential, password)
        user = find_by(email: credential)
        user&.authenticate(password)
    end
      
   
    def reset_session_token!
       update!(session_token: generate_unique_session_token)
       session_token
    end
  
    private

    def generate_unique_session_token
      loop do
        token = SecureRandom.urlsafe_base64
        break token unless exists?(session_token: token)
      end
    end
  
    def ensure_session_token
      self.session_token ||= generate_unique_session_token
    end
end
