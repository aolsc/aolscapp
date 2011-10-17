class User < ActiveRecord::Base
  validates_presence_of :username, :password, :password_confirmation
  validates_presence_of :password_confirmation, :if => :password_changed?
	acts_as_authentic
  belongs_to :member
  has_and_belongs_to_many :roles

   def role_symbols
      (self.roles || []).map {|r| r.role_name.downcase.to_sym}
   end

   def highest_role
     @prev_id = 0
     roles.each do |role|
       if role.id > @prev_id
         @prev_id = role.id
         @max_role = role
        end
      end
      return @max_role.role_name.camelize
   end
   def highest_role_id
     @prev_id = 0
     roles.each do |role|
       if role.id > @prev_id
         @prev_id = role.id
        end
      end
      return @prev_id
   end

   def is_super_admin
     @min_role_id = Role.minimum(:id)

     roles.each do |role|
       if role.id == @min_role_id
         return true
        end
      end
      return false
   end
end
