class AddConsumerIdToProfiles < ActiveRecord::Migration
  def change
  	add_column :profiles, :consumer_id, :integer
  end
end
