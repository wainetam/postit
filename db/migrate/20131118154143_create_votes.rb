class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voteable_id
      t.integer :user_id
      t.string :voteable_type
      t.boolean :vote

      t.timestamps
    end
  end
end
