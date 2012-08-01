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
     @min_role_id = Role.maximum(:id)
     puts "----- " + @min_role_id.to_s
     roles.each do |role|
       puts "^^^^----- " + role.id.to_s
       if role.id <= @min_role_id
         @min_role_id = role.id
         @max_role = role
        end
      end
      return @max_role.role_name.camelize
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

   def self.user_members_cached(center_id)
       @usermembers = []
       Rails.cache.fetch('user_members_' + center_id) {
          @assistantusers = find(:all,:order => 'username', :joins => :member, :conditions => ['members.center_id = ?', center_id])
          @assistantusers.each do |tu|
             if tu.member.center.id.to_s == center_id
             @usermembers << tu.member
            end
          end
       }
       return @usermembers
   end
end
