class LoginController < ApplicationController


  def validate
    puts "in login"
    @user = User.new(params[:user])
    @validateuser = User.find(:all, :conditions => ["username = ? AND password = ? ", @user.username, @user.password ])

    if @validateuser.length == 0
       puts  "invalid"
       flash[:notice]= 'Login Failed.. Please Enter Correct Details'
       redirect_to  :action => :index
    else
      puts "valid"
      render :action => "home"
     end
  end

  def show
    
  end
end
