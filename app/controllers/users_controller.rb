class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :non_signedin_user,    :only=> [:new, :create]

  def destroy

    user=User.find(params[:id])
    if current_user? user
       flash[:notice] = "Admin users cannot destroy themselves."
    else
      user.destroy
      flash[:success] = "User destroyed."
    end

    redirect_to users_path
  end

  def new
    @title = "Sign up"
    @user =User.new
  end

  def index
      @title = "All users"
      @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password=@user.password_confirmation = nil
      render 'new'
    end
  end

  def edit

    @title = "Edit user"
  end

  def update

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private



    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def non_signedin_user
      redirect_to(root_path) if signed_in?
    end
end
