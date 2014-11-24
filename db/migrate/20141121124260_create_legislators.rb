require_relative '../config'

# this is where you should use an ActiveRecord migration to

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :type
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :party
      t.string :state
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :twitter_id
      t.date :birthdate
      t.timestamps
    end
  end
end
