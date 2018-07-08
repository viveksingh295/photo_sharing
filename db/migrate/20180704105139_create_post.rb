class CreatePost < ActiveRecord::Migration[5.1]
  def change
    unless table_exists? :posts
      create_table :posts do |t|
        t.string :caption
        t.string :image_url
        t.references :user, index: true, foreign_key: true

        t.timestamps
      end
      add_index :posts, [:user_id, :created_at]
    end
  end
end
