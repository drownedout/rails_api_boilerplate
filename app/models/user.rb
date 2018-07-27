class User < ApplicationRecord
	# ecrypt password
	has_secure_password
	
	# validations
	validates_presence_of :first_name, :email, :password_digest
end
