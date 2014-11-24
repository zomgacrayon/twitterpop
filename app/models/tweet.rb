require_relative '../../db/config'
require_relative 'legislator'
 require 'twitter'

class Tweet < ActiveRecord::Base
  belongs_to :legislator
end