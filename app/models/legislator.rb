require_relative '../../db/config'

class Legislator < ActiveRecord::Base
  has_many :tweets
end

