class User < ApplicationRecord
	# ecrypt password

	# validations
	validates_presence_of :first_name, :email, :password_digest
end
