class MemberNote < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'added_by'
  belongs_to :member
end
