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
  end

  def remove_its(string)
    string.gsub! /\bit\b/i, "you"
    string.gsub! /\bits\b/i, "your"
    return string
  end

  def on_startup
     scheduler.every '6h' do
       message = JSON.parse(open("http://pokeapi.co/api/v1/description/#{rand(6609) + 1}/").read)["description"]
      remove_its(message)
      tweet(message) 
      end
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

    if $people_talked_to.has_key?(tweet.user.id)
       #then tweet gibberish about their pokemon. Incl. type etc.
       reply(tweet, "Hey, thanks for talking to me.")
    else
      #tweet them their pokemon. and add them to the hash.
        if number == "000"
            final_number = "MissingNo"
          elsif number.to_i > 717
            final_number = number.to_i - 717
          else
            final_number = number
              poke_data = open("http://pokeapi.co/api/v1/pokemon/#{final_number}/").read
              poke_tweet = JSON.parse(poke_data)["name"]
              reply(tweet, "Hello, you are #{poke_tweet}.")
              $people_talked_to[tweet.user.id] = tweet.user.name
        end
      end
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

