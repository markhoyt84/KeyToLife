class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  before_action :get_categories
  # GET /resource/sign_in
  respond_to :json, :js

  def new
    super
  end


  # POST /resource/sign_in
  def create
    super
    p current_user
    p current_user == true
    session[:user_id] = current_user.id
    @user = session[:user_id]
    p @user
    @last = current_user.last_name
    @lastletter =  @last.split('').first
    session[:username] = current_user.first_name + " " + @lastletter
    p @username
  end

  # DELETE /resource/sign_out
  def destroy
    super
    session[:user_id] = 'guest'
  end

  # protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :attribute
  end

  private
    def get_categories
      @categories = Category.all
    end

    def get_current_user
      @user = current_user
    end
end
