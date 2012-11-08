class SessionsController < ApplicationController

  def new
  	user = User.find_by_remember_token(cookies[:remember_token])
  	if user
 		flash[:success] = "You Are already Signed In!"
  		redirect_to user
  	end
  end

  def create
  	  user = User.find_by_email(params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password])
	    sign_in user
	    flash[:success] = "Welcome to the Sample App!"
      	redirect_to user
	  else
	    flash[:error] = 'Invalid email/password combination'
	    render 'new'
	  end
  end

  def destroy
  	sign_out
	flash[:success] = "Good Bye!"
    redirect_to root_url
  end

end
