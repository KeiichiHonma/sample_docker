class HomeController < ApplicationController
  include LatestContents
  before_action -> { latest_news(2) }

  def index

  end


end
