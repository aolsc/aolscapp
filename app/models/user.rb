class User < ActiveRecord::Base
  validates_presence_of :username, :password, :password_confirmation
  validates_presence_of :password_confirmation, :if => :password_changed?
	acts_as_authentic
  belongs_to :member
  has_and_belongs_to_many :roles

   def role_symbols
      (self.roles || []).map {|r| r.role_name.downcase.to_sym}
   end

end
