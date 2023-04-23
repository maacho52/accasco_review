class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    #一覧
    @sites = Site.all
    @arranges = Arrange.all

    #サイト新規登録
    @site_new = Site.new
    @site = Genre.new(site_params)
    @site.save
    redirect_to admin_root_path

    #アレンジ新規登録
    @arrange_new = Arrange.new
    @arrange = Arrange.new(arrange_params)
    @arrange.save
    redirect_to admin_root_path
  end

  private

  def site_params
    params.require(:site).permit(:name)
  end

  def arrange_params
    params.require(:arrange).permit(:body)
  end

end
