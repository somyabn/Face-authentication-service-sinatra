class CreateConsumersTable < ActiveRecord::Migration
  def change
  	create_table :consumers do |t|
  		t.string :name
  		t.string :key
  		t.string :token
  	end
  end
end
