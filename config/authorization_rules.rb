authorization do
  role :admin do
    has_permission_on [:user_sessions, :centers, :tags, :courses, :users, :member_courses, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags]
  end

  role :volunteer do
    has_permission_on [:member_courses, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags]
    has_permission_on :users, :to => [:edit, :update]
    has_permission_on :courses, :to => [:index, :show]
  end

  role :teacher do
    has_permission_on [:member_courses, :centers, :tags, :course_schedules, :member_report], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:members], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :membersearch, :save_tags]
    has_permission_on :users, :to => [:edit, :update]
    has_permission_on :courses, :to => [:index, :show]
  end

  role :guest do
    has_permission_on :members, :to => [:index, :show]
    has_permission_on :centers, :to => [:index, :show]
  end
end
