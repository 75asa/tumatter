class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      # auto save method
      log_in @user
      flash[:success] = "Welcom to Tumatter!!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新成功時のみ扱う
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    # 許可された項目だけを引数とする
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
    end

    # beforeAction

    # ログイン済みユーザーかを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
