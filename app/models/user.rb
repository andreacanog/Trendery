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
    uniqueness: true, 
    length: { in: 3..255 }, 
    format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :session_token, presence: true, uniqueness: true
    validates :password, length: { in: 6..255 }, allow_nil: true
  
    before_validation :ensure_session_token
  
    # Ensure session token is set before validation

    def self.find_by_credentials(credential, password)
        user = User.find_by(email: credential)
        user&.authenticate(password)
    end
      
   
    def reset_session_token!
       self.update!(session_token: generate_unique_session_token)
       self.session_token
    end
  
    private

    def generate_unique_session_token
        loop do
          token = SecureRandom.base64
          break token unless User.exists?(session_token: token)
        end
    end
  
    def ensure_session_token
      self.session_token ||= self.class.generate_unique_session_token
    end
end
  
