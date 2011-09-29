class MemberTagging < ActiveRecord::Base
  belongs_to :member
  belongs_to :tag
end
