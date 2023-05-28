class Public::HomesController < ApplicationController
  def top
    @arranges = Arrange.all
    @scores = Score.last(4)
  end
end
