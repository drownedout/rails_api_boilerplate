class User < ApplicationRecord
	# ecrypt password
	has_secure_password
	
	# validations
	validates_presence_of :first_name, :email, :password_digest
	validates_uniqueness_of :email, case_sensative: false
	validates_format_of :email, with: /@/

	before_save :email_to_downcase

	def email_to_downcase
	  self.email = self.email.delete(' ').downcase
	end
end
