module SessionsHelper
  def sign_in(user)
    cookies[:remember_token] = { value: user.remember_token,
                                 expires: 2.weeks.from_now.utc}
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])  
  end

  def signed_in?
    !current_user.nil? #这里不能使用@current_user,跳转后就无法使用了
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end
  
  def redirect_back_or(default)
    redirect_to ( session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
end
