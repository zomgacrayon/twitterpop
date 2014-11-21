require_relative '../../db/config'
require_relative 'legislator'
# require_relative 'lib/sunlight_legislators_importer'

def list_senators(select_state)
    legislator = Legislator.select("lastname","firstname","party").where("state = '#{select_state}'")
    puts "Senators:"
    legislator.where("title = 'Sen'")

      legislator.each do |field|
        puts "#{field.firstname}" + " " + "#{field.lastname}" + " " + "(" + "#{field.party}" + ")"
      end
end

def list_reps(select_state)
    legislator = Legislator.select("lastname","firstname","party").where("state = '#{select_state}'")
    puts "House of Reps:"
    legislator.where("title = 'Rep'")

      legislator.each do |field|
        puts "#{field.firstname}" + " " + "#{field.lastname}" + " " + "(" + "#{field.party}" + ")"
      end
end

# list_senators("HI")
# list_reps("HI")

def gender_legislator(select_gender,select_title)
    gender_title = Legislator.where("gender = '#{select_gender}'").where("title = '#{select_title}'").count
    total = Legislator.where("title = '#{select_title}'").count
    percentage = ((gender_title.to_f / total.to_f)*100).round
    if select_gender == "M"
      puts "Male" + " "+ "#{select_title}: " "#{gender_title} " + "(" + percentage.to_s + "%" + ")"
    else
      puts "Female" + " " + "#{select_title}: " "#{gender_title} " + "(" + percentage.to_s + "%" + ")"
    end
end

# puts gender_legislator("F","Rep")
# puts gender_legislator("M","Rep")
# puts gender_legislator("F","Sen")
# puts gender_legislator("M","Sen")

def state_dist
  senator = Legislator.select("state").where("title = 'Sen'").where("in_office = '1'").group("state").count
  rep = Legislator.select("state").where("title = 'Rep'").where("in_office = '1'").group("state").count

  rep = rep.sort_by {|key,value| value}.reverse!


 rep.each do |key, value|
  "#{key}: " "#{senator[key]} Senators, #{value} Representative(s)"
 end

end

state_dist

def count
  p senators = Legislator.where("title = 'Sen'").count
  p representatives = Legislator.where("title= 'Rep'").count
end

def delete_inactive
p Legislator.where(:in_office => 0).destroy_all
end

# delete_inactive
# count

