class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook] 
  validates :curp, presence: true, uniqueness: true, length: {minimum: 18, maximum: 18}
  validates :no_control, presence: true, uniqueness: true, length: {minimum: 14, maximum: 14}

  def self.from_omniauth(auth)
  	where(provider: auth[:provider], uid: auth[:uid]).first_or_create do |student|
  		if auth[:info]
  			student.email = auth[:info][:email]
  			student.name = auth[:info][:name]
  		end
  		student.password = Devise.friendly_token[0,20]
  	end
  end
end
