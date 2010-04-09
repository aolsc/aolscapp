module MembersHelper
	def checked?(gender) 
		@member.gender == gender rescue nil 
	end 
end
