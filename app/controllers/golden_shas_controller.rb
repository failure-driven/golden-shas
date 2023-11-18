class GoldenShasController < ApplicationController
  def index
    @seed = Seed.instance
  end
end
