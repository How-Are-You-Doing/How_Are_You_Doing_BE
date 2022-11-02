class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.references :followee, foreign_key: { to_table: :users }, null: false
      t.integer :request_status

      t.timestamps
    end
  end
end
