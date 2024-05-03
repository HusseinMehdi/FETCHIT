class User < ApplicationRecord
    has_secure_password
    
    # Validates that the email is unique
    validates :email, uniqueness: { case_sensitive: false, message: 'wurde bereits angenommen' }
end
