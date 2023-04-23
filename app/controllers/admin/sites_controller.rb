class Admin::SitesController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @site = Site.find(params[:id])
  end

  def create
    @site = Site.new(site_params)
    @site.save
    redirect_to admin_root_path
  end

  def update
    @site = Site.find(params[:id])
    @site.update(site_params)
    redirect_to admin_root_path
  end

  private

  def site_params
    params.require(:site).permit(:name, :score_id)
  end
end
