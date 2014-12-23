require 'twitter_ebooks'
require 'dotenv'
Dotenv.load
CONSUMER_KEY = ENV['MY_CONSUMER_KEY']
SECRET_CONSUMER_KEY = ENV['MY_SECRET_CONSUMER_KEY']
ACCESS_KEY = ENV['MY_ACCESS_KEY']
SECRET_ACCESS_KEY = ENV['MY_SECRET_ACCESS_KEY']


class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    self.consumer_key = CONSUMER_KEY 
    self.consumer_secret =  SECRET_CONSUMER_KEY 
  end

  def on_startup
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
       ["blinky blinky blonko.", "Christmas elves, Phbbbbt!", "All I want for Xmas is blerg"].each {|item| tweet(item) }
      # pictweet("hi", "cuteselfie.jpg")

    end

  def on_message(dm)
    # Reply to a DM
    # reply(dm, "secret secrets")
  end

  def on_follow(user)
    # Follow a user back
    # follow(user.screen_name)
  end

  def on_mention(tweet)
    # Reply to a mention
    # reply(tweet, "oh hullo")
  end

  def on_timeline(tweet)
    # Reply to a tweet in the bot's timeline
    # reply(tweet, "nice tweet")
  end
end

MyBot.new("superbowl3000") do |bot|
  bot.access_token = ACCESS_KEY 
  bot.access_token_secret = SECRET_ACCESS_KEY

end
