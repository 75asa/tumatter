class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(microposts_params)
    if @micropost.save
      flash[:success] = "Micropost created !!"
      redirect_to root_url
    else
      # マイクロポストの投稿が失敗すると、 Homeページは@feed_itemsインスタンス変数を期待しているため
      # ただし、ページ分割されたフィードを返す場合は動作しない
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    # redirect_to request.referrer || root_url
    redirect_back(fallback_location: root_url)
  end

  private

    def microposts_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
