class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception


def set_layout
  if @current_user.present?
  self.class.layout "employee" if @current_user.position = "Staff"
  end
  #self.class.layout "application" if @current_user.position = "Manager"
end
 
def current_user
  if session[:user_id]
    @current_user ||= Employee.find(session[:user_id])
  end
end



def authenticate
  if session[:user_id].nil?
    redirect_to(root_path)
  end
end

def logout
    reset_session
    redirect_to root_path
    flash[:notice] = "Success Logout "
  end

end