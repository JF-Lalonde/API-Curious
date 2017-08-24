class RedditService
  def initialize(subreddit)
    @subreddit = subreddit
    @conn = Faraday.new(url: "https://www.reddit.com/api/v1/access_token")
    @conn.basic_auth("NmhmKTGIJiuvVg", "8gq9vgXkzV-9nobWNJpc_P7fUpg")
    response = @conn.post do |req|
      req.body ="grant_type=authorization_code&code=#{params[:code]}&redirect_uri=http://127.0.0.1:3000/auth/reddit/callback"
    end
    @access_token = JSON.parse(response.body)["access_token"]
    refresh_token = JSON.parse(response.body)["refresh_token"]
  end

  def subreddit_response
    @conn.get("https://oauth.reddit.com/r/#{@subreddit}") do |request|
      request.headers[:Authorization] = "bearer #{@access_token}"
    end
  end

  def comments_response
    @conn.get("https://oauth.reddit.com/r/#{@subreddit}/comments") do |request|
      request.headers[:Authorization] = "bearer #{@access_token}"
    end
  end

  def identity_response
    @conn.get("https://oauth.reddit.com/api/v1/me") do |request|
      request.headers[:Authorization] = "bearer #{access_token}"
    end
  end

  def subscriptions_response
    @conn.get("https://oauth.reddit.com/subreddits/mine/") do |request|
      request.headers[:Authorization] = "bearer #{access_token}"
    end
  end

  def pretty_parse(conn_response)
    JSON.parse(conn_response.body, symbolize_names: :true)[:data][:children][0][:data]
  end

  def self.get_all_info(subreddit)
    new(subreddit)
    pretty_parse(subreddit_response)
    pretty_parse(comments_response)
    pretty_parse(identity_response)
    pretty_parse(subscriptions_response)
  end
end
