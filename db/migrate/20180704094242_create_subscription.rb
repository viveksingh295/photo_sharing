class CreateSubscription < ActiveRecord::Migration[5.1]
  def change
    unless table_exists? :subscriptions
      create_table :subscriptions do |t|
        t.integer :follower_id, index: true
        t.integer :followed_id, index: true

        t.timestamps
      end
      add_index :subscriptions, [:follower_id, :followed_id], unique: true
    end
  end
end
