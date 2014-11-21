require 'csv'
require_relative '../app/models/legislator'

class SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
  wanted_columns = ["title", "firstname", "middlename", "lastname", "party", "state", "in_office", "gender", "phone", "fax", "website", "webform", "twitter_id", "birthdate"]

    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
        row_hashed = row.to_hash
        attributes_hash = Hash.new
        wanted_columns.each do |field|
        attributes_hash[field] = row_hashed[field]
      end
      Legislator.create(attributes_hash)
    end
  end
end


# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
  # raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
  # SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
