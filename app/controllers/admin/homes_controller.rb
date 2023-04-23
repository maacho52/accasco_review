class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    #一覧
    @sites = Site.all
    @arranges = Arrange.all
    
    @site_new = Site.new
    @arrange_new = Arrange.new    
  end

  private

  def site_params
    params.require(:site).permit(:name)
  end

  def arrange_params
    params.require(:arrange).permit(:body)
  end

end
