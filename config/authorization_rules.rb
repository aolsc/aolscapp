authorization do
  role :superadmin do
    has_permission_on [:user_sessions, :centers, :tags, :courses, :users, :member_courses, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags,:save_notes]
  end

  role :admin do
    has_permission_on [:user_sessions, :tags, :users, :member_courses, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags,:save_notes]
  end

  role :volunteer do
    has_permission_on [:member_courses, :tags, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags,:save_notes]
  end

  role :teacher do
    has_permission_on [:member_courses, :tags, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags,:save_notes]
  end

  role :guest do
    has_permission_on :members, :to => [:index, :show]
    has_permission_on :centers, :to => [:index, :show]
  end
end
