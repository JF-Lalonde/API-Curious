class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
    #subreddit_response = conn.get("https://oauth.reddit.com/r/#{subreddit}") do |request|
    #request.headers[:Authorization] = "bearer #{access_token}"
    #end

    #comments_response = Faraday.get("https://oauth.reddit.com/r/#{subreddit}/comments") do |request|
    #request.headers[:Authorization] = "bearer #{access_token}"
    #end

    #identity_response = Faraday.get("https://oauth.reddit.com/api/v1/me") do |request|
    #request.headers[:Authorization] = "bearer #{access_token}"
    #end

    #subreddit_subscriptions_response = Faraday.get("https://oauth.reddit.com/subreddits/mine/") do |request|
    #request.headers[:Authorization] = "bearer #{access_token}"
    #end


    #@subreddit_info = JSON.parse(subreddit_response.body, symbolize_names: :true)[:data][:children][0][:data]
    #@comments_info = JSON.parse(comments_response.body)
    #@identity_info = JSON.parse(identity_response.body)
    #@subreddit_subscriptions_info = JSON.parse(subreddit_subscriptions_response.body)
    #binding.pry
  #end
end
