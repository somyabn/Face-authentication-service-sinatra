class CreateProfilesTable < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.string :username
  		t.string :image_url
  		t.boolean :trained
  		t.boolean :confirmed
  	end
  end
end
