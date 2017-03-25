class UsersController < ApplicationController

  before_action :signed_in_user
  before_action :correct_user
  before_action :admin_user?, only: [:index, :new, :create, :destroy, :reset, :reset_password, :search]
  before_action :set_user, only: [:edit, :edit_password, :update, :update_password, :reset, :reset_password, :destroy]
  before_action :editing_self?, only: [:edit, :edit_password, :update, :update_password]

  def index
    @users = User.order(:id).paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #sign_in @user
      #flash[:success] = "Welcome."
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
  end

  def edit_password
  end

  def update
    if @user.authenticate(params[:user][:password_previous])
      if @user.update_attributes(user_params)
        flash[:success] = "User account updated"
        redirect_to home_url
      else
        render 'edit'
      end
    else
      flash[:error] = "Incorrect previous password"
      redirect_to edit_user_path
    end
  end

  def update_password
    if @user.authenticate(params[:password_previous])
      if @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
        flash[:success] = "User password updated"
        redirect_to home_url
      else
        render 'edit_password'
      end
    else
      flash[:error] = "Incorrect previous password"
      render 'edit_password'
    end
  end

  def reset

  end

  def reset_password
    if @user.update_attributes(password: params[:password], password_confirmation: params[:password_confirmation])
      flash[:success] = "User password reset"
      redirect_to home_url
    else
      render 'reset'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def search
    @users = User.where("name ilike ?", "%#{params[:user_name]}%").order(:id).paginate(page: params[:page], per_page: 5)
    render 'index'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :user_role_id, :password, :password_confirmation)
  end

  def editing_self?
    if current_user.user_role.name != 'Admin'
      if current_user.id != params[:id].to_i
        redirect_to(root_url)
      end
    end
  end


end