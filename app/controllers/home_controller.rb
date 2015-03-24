class HomeController < ApplicationController

  def landing
    @tweets = Tweet.bydate
  end

end
