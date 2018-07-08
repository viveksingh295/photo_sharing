class CreateUser < ActiveRecord::Migration[5.1]
  def change
    unless table_exists? :users
      create_table :users do |t|
        t.string   "name"
        t.string   "email", index: { unique: true }
        t.string   "password_digest"

        t.timestamps
      end
    end
  end
end
