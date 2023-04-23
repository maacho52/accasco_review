class Admin::ArrangesController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @arrange = Arrange.find(params[:id])
  end
  
  def create
    @arrange = Arrange.new(arrange_params)
    @arrange.save
    redirect_to admin_root_path
  end  
  
  def update
    @arrange = Arrange.find(params[:id])
    @arrange.update(arrange_params)
    redirect_to admin_root_path
  end
  
  private
  
  def arrange_params
    params.require(:arrange).permit(:body)
  end
end
