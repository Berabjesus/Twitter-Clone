class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    
  end
end
