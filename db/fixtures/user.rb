Center.seed(:city) do |s|
  s.city = "Santa Clara"
  s.state = "CA"
  s.country = "USA"
end

Center.seed(:city) do |s|
  s.city = "San Jose"
  s.state = "CA"
  s.country = "USA"
end


Member.seed(:emailid) do |s|
  s.firstname = "super"
  s.lastname = "admin"
  s.emailid = "super@sc.com"
  s.homephone = "408-555-5555"
  s.taken_course = "1"
  s.center_id = 1
end

User.seed(:username, :email) do |s|
  s.username = "superadmin"
  s.email = "super@sc.com"
  s.password = "superadmin"
  s.password_confirmation = "superadmin"
  s.member_id = 1
end


Member.seed(:emailid) do |s|
  s.firstname = "vol"
  s.lastname = "sc"
  s.emailid = "vol@sc.com"
  s.homephone = "408-111-1111"
  s.taken_course = "1"
  s.center_id = 1
end

User.seed(:username, :email) do |s|
  s.username = "volsc"
  s.email = "vol@sc.com"
  s.password = "volsc"
  s.password_confirmation = "volsc"
  s.member_id = 2
end

Member.seed(:emailid) do |s|
  s.firstname = "tc"
  s.lastname = "sc"
  s.emailid = "tc@sc.com"
  s.homephone = "408-333-3333"
  s.taken_course = "1"
  s.center_id = 1
end

User.seed(:username, :email) do |s|
  s.username = "tcsc"
  s.email = "tc@sc.com"
  s.password = "tcsc"
  s.password_confirmation = "tcsc"
  s.member_id = 3
end


Member.seed(:emailid) do |s|
  s.firstname = "adm"
  s.lastname = "sc"
  s.emailid = "adm@sc.com"
  s.homephone = "408-444-4444"
  s.taken_course = "1"
  s.center_id = 1
end

User.seed(:username, :email) do |s|
  s.username = "admsc"
  s.email = "adm@sc.com"
  s.password = "admsc"
  s.password_confirmation = "admsc"
  s.member_id = 4
end


Member.seed(:emailid) do |s|
  s.firstname = "vol"
  s.lastname = "sj"
  s.emailid = "vol@sj.com"
  s.homephone = "650-111-1111"
  s.taken_course = "1"
  s.center_id = 2
end

User.seed(:username, :email) do |s|
  s.username = "volsj"
  s.email = "vol@sj.com"
  s.password = "volsj"
  s.password_confirmation = "volsj"
  s.member_id = 5
end


Member.seed(:emailid) do |s|
  s.firstname = "tc"
  s.lastname = "sj"
  s.emailid = "tc@sj.com"
  s.homephone = "650-333-3333"
  s.taken_course = "1"
  s.center_id = 2
end

User.seed(:username, :email) do |s|
  s.username = "tcsj"
  s.email = "tc@sj.com"
  s.password = "tcsj"
  s.password_confirmation = "tcsj"
  s.member_id = 6
end

Member.seed(:emailid) do |s|
  s.firstname = "adm"
  s.lastname = "sj"
  s.emailid = "adm@sj.com"
  s.homephone = "650-444-4444"
  s.taken_course = "1"
  s.center_id = 2
end

User.seed(:username, :email) do |s|
  s.username = "admsj"
  s.email = "adm@sj.com"
  s.password = "admsj"
  s.password_confirmation = "admsj"
  s.member_id = 7
end

Role.seed(:role_name) do |s|
  s.role_name = "superadmin"
end

Role.seed(:role_name) do |s|
  s.role_name = "admin"
end

Role.seed(:role_name) do |s|
  s.role_name = "teacher"
end

Role.seed(:role_name) do |s|
  s.role_name = "volunteer"
end

Member.seed(:emailid) do |s|
  s.firstname = "sc"
  s.lastname = "mem1"
  s.emailid = "scmem1@sc.com"
  s.homephone = "408-111-9990"
  s.taken_course = "1"
  s.center_id = 1
end


Member.seed(:emailid) do |s|
  s.firstname = "sc"
  s.lastname = "mem2"
  s.emailid = "scmem2@sc.com"
  s.homephone = "408-222-9990"
  s.taken_course = "1"
  s.center_id = 1
end


Member.seed(:emailid) do |s|
  s.firstname = "sc"
  s.lastname = "mem3"
  s.emailid = "scmem3@sc.com"
  s.homephone = "408-333-9990"
  s.taken_course = "1"
  s.center_id = 1
end

Member.seed(:emailid) do |s|
  s.firstname = "sc"
  s.lastname = "mem4"
  s.emailid = "scmem4@sc.com"
  s.homephone = "408-444-9990"
  s.taken_course = "1"
  s.center_id = 1
end

Member.seed(:emailid) do |s|
  s.firstname = "sc"
  s.lastname = "mem5"
  s.emailid = "scmem5@sc.com"
  s.homephone = "408-555-9990"
  s.taken_course = "0"
  s.center_id = 1
end

Member.seed(:emailid) do |s|
  s.firstname = "sj"
  s.lastname = "mem1"
  s.emailid = "scmem1@sj.com"
  s.homephone = "650-111-9990"
  s.taken_course = "1"
  s.center_id = 2
end

Member.seed(:emailid) do |s|
  s.firstname = "sj"
  s.lastname = "mem2"
  s.emailid = "scmem2@sj.com"
  s.homephone = "650-222-9990"
  s.taken_course = "1"
  s.center_id = 2
end

Member.seed(:emailid) do |s|
  s.firstname = "sj"
  s.lastname = "mem3"
  s.emailid = "scmem3@sj.com"
  s.homephone = "650-333-9990"
  s.taken_course = "1"
  s.center_id = 2
end

Member.seed(:emailid) do |s|
  s.firstname = "sj"
  s.lastname = "mem4"
  s.emailid = "scmem4@sj.com"
  s.homephone = "650-444-9990"
  s.taken_course = "1"
  s.center_id = 2
end

Member.seed(:emailid) do |s|
  s.firstname = "sj"
  s.lastname = "mem5"
  s.emailid = "scmem5@sj.com"
  s.homephone = "650-555-9990"
  s.taken_course = "0"
  s.center_id = 2
end



