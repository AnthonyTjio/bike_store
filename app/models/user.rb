class User < ActiveRecord::Base
	attr_accessor :old_password, :password, :password_confirmation

	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :username, :user_type
	validates_uniqueness_of :username, :case_sensitive => false
	validates_length_of :password, :minimum => 6

	def self.authenticate(username, password)
		user = User.find_by(username: username)
		if(user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt))
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

end
