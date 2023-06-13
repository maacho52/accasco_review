class Public::HomesController < ApplicationController
  def top
    @arranges = Arrange.all
    @scores = Score.all.last(4)
  end
end
