include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  #Remove the shared part to here, from user_pages_spec.rb
  cookies[:remember_token] = user.remember_token
end
