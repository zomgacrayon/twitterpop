require_relative 'db/config'
require_relative 'app/models/legislator'
require_relative 'app/models/sen'
require_relative 'app/models/rep'
require_relative 'app/models/del'
require_relative 'app/models/com'
require_relative 'app/models/tweet'
require 'twitter'
# require_relative 'lib/sunlight_legislators_importer'

def list_senators(select_state)
    legislator = Legislator.select("lastname","firstname","party").where("state = '#{select_state}'")
    puts "Senators:"
    legislator.where("type = 'Sen'")

      legislator.each do |field|
        puts "#{field.firstname}" + " " + "#{field.lastname}" + " " + "(" + "#{field.party}" + ")"
      end
end

def list_reps(select_state)
    legislator = Legislator.select("lastname","firstname","party").where("state = '#{select_state}'")
    puts "House of Representatives:"
    legislator.where("type = 'Rep'")

      legislator.each do |field|
        puts "#{field.firstname}" + " " + "#{field.lastname}" + " " + "(" + "#{field.party}" + ")"
      end
end

# list_senators("HI")
# list_reps("HI")

def gender_legislator(select_gender,select_type)
    gender_type = Legislator.where("gender = '#{select_gender}'").where("type = '#{select_type}'").count
    total = Legislator.where("type = '#{select_type}'").count
    percentage = ((gender_type.to_f / total.to_f)*100).round
    if select_gender == "M"
      puts "Male" + " "+ "#{select_type}: " "#{gender_type} " + "(" + percentage.to_s + "%" + ")"
    else
      puts "Female" + " " + "#{select_type}: " "#{gender_type} " + "(" + percentage.to_s + "%" + ")"
    end
end

# puts gender_legislator("F","Rep")
# puts gender_legislator("M","Rep")
# puts gender_legislator("F","Sen")
# puts gender_legislator("M","Sen")

def state_dist
  senator = Legislator.select("state").where("type = 'Sen'").where("in_office = '1'").group("state").count
  rep = Legislator.select("state").where("type = 'Rep'").where("in_office = '1'").group("state").count

  rep = rep.sort_by {|key,value| value}.reverse!


 rep.each do |key, value|
  p "#{key}: " "#{senator[key]} Senators, #{value} Representative(s)"
 end

end

# state_dist

def count
  p senators = Legislator.where("type = 'Sen'").count
  p representatives = Legislator.where("type= 'Rep'").count
end

def delete_inactive
Legislator.where(:in_office => 0).destroy_all
end

# delete_inactive
count

#tweet
client = Twitter::REST::Client.new do |config|
 config.consumer_key        = "By4xvw5Te5PssBIgdO1BeFxNs"
 config.consumer_secret     = "ElIkbSXrKZenEUqPU2AoaPkgW13Et5YA9voH9dkOkvbCVmAKd5"
 config.access_token        = "123976307-AwqybvaEPDjVU7RExyipBPWTPWvUz1kUfY4raf3G"
 config.access_token_secret = "iA90lvyaNN3cXgPRAlOpbO1RcOLCkXiQFtMpRXxDzFUlP"
end


legislators = Legislator.limit(5)

legislators.each do |legislator|
  if legislator.twitter_id != ""
    tweets = client.user_timeline(legislator.twitter_id)[0..9]
    tweets.each do |tweet|
      new_tweet = legislator.tweets.new(text: tweet.text)
      new_tweet.save
    end
  end
end
