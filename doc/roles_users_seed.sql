insert into roles_users(user_id, role_id) values (1, 1);
insert into roles_users(user_id, role_id) values (2, 4);
insert into roles_users(user_id, role_id) values (3,3);
insert into roles_users(user_id, role_id) values (4,2);
insert into roles_users(user_id, role_id) values (5,4);
insert into roles_users(user_id, role_id) values (6,3);
insert into roles_users(user_id, role_id) values (7,2);
commit;



RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 1
  s.role_id = 1
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 2
  s.role_id = 4
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 3
  s.role_id = 3
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 4
  s.role_id = 2
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 5
  s.role_id = 4
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 6
  s.role_id = 3
end

RolesUsers.seed(:user_id, :role_id) do |s|
  s.user_id = 7
  s.role_id = 2
end