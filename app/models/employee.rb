require 'bcrypt'
class Employee < ActiveRecord::Base
	belongs_to :department

	validates_presence_of :name, :message => 'Cannot Empty'
	validates_presence_of :ic, :message => 'Cannot Empty'
	validates_length_of :ic, :minimum => 12
	validates_length_of :ic, :maximum => 12
	validates_presence_of :startdate 
	validates_presence_of :address
	validates_presence_of :phone
	validates_presence_of :position
	validates_presence_of :email
		
def password=(pass)
		@password = pass
		@password = self.hashed_password = Employee.encrypt(@password)
	end

	def self.encrypt(pass)
		BCrypt::Password.create(pass)
	end

	def self.authenticate(email,pass)
		employee = where("email = ?", email).first
		return nil if employee.nil?
		return employee if BCrypt::Password.new(employee.hashed_password) == pass
		nil
	end


end
