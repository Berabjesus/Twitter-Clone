class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :follow
  def index
    if user_signed_in?
      @tweets = Tweet.all.order("created_at DESC LIMIT 20")
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
      if @tweet.save 
       redirect_to tweets_path, notice: 'Tweet was successfully created.' 
      else
        str = "Tweet not saved!"
        new_line = "<br/>"
        @tweet.errors.full_messages.each do |msg|
          str << new_line
          str << msg
        end
        respond_to do |format|
          format.html { redirect_to tweets_path, alert: str}
        end
      end
  end

  def edit
    @tweet = set_tweet
    if current_user.id != @tweet.user.id
      redirect_to tweets_path, notice: 'You dont own this tweet'
      return
    end
  end

  def update
    @tweet = set_tweet
    if @tweet.update(update_tweet)
      redirect_to tweet_path, notice: 'Tweet was successfully updated.' 
    else
      str = "Tweet not saved!"
      new_line = "<br/>"
      @tweet.errors.full_messages.each do |msg|
        str << new_line
        str << msg
      end
      respond_to do |format|
        format.html { redirect_to tweets_path, alert: str}
      end
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def destroy
    @tweet = set_tweet
    if current_user.id != @tweet.user.id
      redirect_to tweets_path, notice: 'You dont own this tweet'
      return
    end
    if @tweet.destroy
      redirect_to tweets_path, notice: 'Tweet was successfully Deleted.' 
    else
      str = "Tweet not saved!"
      new_line = "<br/>"
      @tweet.errors.full_messages.each do |msg|
        str << new_line
        str << msg
      end
      respond_to do |format|
        format.html { redirect_to tweets_path, alert: str}
      end
    end
  end

  private

  def tweet_params
    params.permit(:tweet)
  end

  def update_tweet
    params.require(:tweet).permit(:tweet)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def follow
    @follow = []
    count = 0
    User.count.times do |i|
      break if count == 2
      @follow << User.all[i] if !@follow.any?(User.all[i])
      count += 1
    end
  end
end
