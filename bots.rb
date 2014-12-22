require 'twitter_ebooks'

# This is an example bot definition with event handlers commented out
# You can define and instantiate as many bots as you like

class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    self.consumer_key = "5XlN7yuNfOKNkwFlCVkkxYm8r"
    self.consumer_secret = "8dncHO7XK4gZJGTR6JIetvxzhH1HGiBmhyBZISOb8LR5SQOH96"
  end

  def on_startup
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
       ["Things love for I do.", "Christmas, Phbbbbt!", "Blerg 2: Revenge of Blerg"].each {|item| tweet(item) }
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

# Make a MyBot and attach it to an account
MyBot.new("superbowl3000") do |bot|
  bot.access_token = "2194383865-M1EfeIOuyN8GFpbKuDdPUNqiy6x84O0mpqrpQty"
  bot.access_token_secret = "v6Li5YlyarzFzswtOsf090fXsBAJAKQvJDwcv9e11DI9n" 
end
