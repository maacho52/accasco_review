class Public::HomesController < ApplicationController
  def top
    @arranges = Arrange.all
  end  
end
