class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]  
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated"
        sign_in @user
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:sucess] = "User destroyed"
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end


  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def passwordinfo #nothing to do
  end

  def password_forget
    user = User.find_by_password_reset_token(params[:token])
    if user
      # user.send_password_reset 
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      redirect_to passwordinfo_path, flash[:error]="User account is not valid"
    end
  end

  def edit_password
    @user = User.find_by_password_reset_token(params[:token])
    @token = params[:token]
    puts "EEEEEEEthe user name is:#{@user.email}"
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to passwordinfo_path, flash[:alert] = "Password reset has expired"
    end
  end

  def reset_password
    @user = User.find_by_password_reset_token!(params[:password_reset_token])
    #check the time again
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to passwordinfo_path, flash[:alert] = "Password reset has expired"
    elsif @user.update_attributes(params[:user])
      redirect_to signin_url, :notice => "Password has been reset!"
    else
      render password_edit
    end
  end

  private

  # move to session_helper.rb, in order to code reuse
  # def signed_in_user
  # unless signed_in?
  # store_location
  # redirect_to signin_path, notice: "Please sign in." unless signed_in?
  # end
  # end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

