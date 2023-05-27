class Public::HomesController < ApplicationController
  def top
    @arranges = Arrange.all
    @scores = Score.first(4)
  end  
end
