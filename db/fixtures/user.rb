user = User.seed(:username, :email) do |s|  
  s.username = "admin"   
  s.email = "admin@admin.com"   
  s.password = "admin"
  s.password_confirmation = "admin"   
end