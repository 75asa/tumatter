class UsersController < ApplicationController

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
      # save method
      flash[:success] = "Welcom to Tumatter!!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    # 許可された項目だけを引数とする
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
    end
end
