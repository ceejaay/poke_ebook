require 'twitter_ebooks'
require 'dotenv'
require 'open-uri'
#require 'user_hash'
#require 'colorator'
#require 'pokegem'

Dotenv.load
CONSUMER_KEY = ENV['MY_CONSUMER_KEY']
SECRET_CONSUMER_KEY = ENV['MY_SECRET_CONSUMER_KEY']
ACCESS_KEY = ENV['MY_ACCESS_KEY']
SECRET_ACCESS_KEY = ENV['MY_SECRET_ACCESS_KEY']


$people_talked_to = {}
class MyBot < Ebooks::Bot
  # Configuration here applies to all MyBots
  def configure
    self.consumer_key = CONSUMER_KEY 
    self.consumer_secret =  SECRET_CONSUMER_KEY 
        @tweet_words = %w{witches brew witches-brew tim-duncan tim duncan spaaaahkle I will now say a list of words Homestar superb owl best thinky blerg there is what can to do go around but the monster mash where orange bear teddy baby babby pound violet slid out stylus ruby i_heart_radio bling pills gas relief journey lotion root beer root_beer }
  end

  def on_startup
      # Tweet something every 24 hours
      # See https://github.com/jmettraux/rufus-scheduler
      
      scheduler.every '24h' do
      new_tweet = ""
        rand(1..5).times do 
          new_tweet << @tweet_words.sample + " "
        end

        new_tweet.strip!.capitalize!
        new_tweet << [".", "?", "!" " #FTW"].sample
        tweet(new_tweet)
      end      

      # pictweet("hi", "cuteselfie.jpg")

    #puts "hello World".red
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
    final_number = nil
    number = tweet.user.id.to_s
    number = number.split(//).last(3).join
    if number == "000"
        final_number = "MissingNo"
      elsif number.to_i > 717
        final_number = number.to_i - 717
      else
        final_number = number
    end
    poke_data = open("http://pokeapi.co/api/v1/pokemon/#{final_number}/").read
    poke_tweet = JSON.parse(poke_data)["name"]
    reply(tweet, "Hello, you are #{poke_tweet}.")
    
    $people_talked_to[tweet.user.id] = tweet.user.name
    puts $people_talked_to
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

