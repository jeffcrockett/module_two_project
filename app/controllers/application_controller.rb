class ApplicationController < ActionController::Base

  helper_method :current_user_id

  def current_user_id
    if @user
      @user.id
    else
      @user = User.find_by(id: session[:user_id])
    end
  end
end
