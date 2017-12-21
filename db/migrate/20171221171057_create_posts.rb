class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :description, null: false
      t.datetime :date, null: false
      t.references :user, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
    
    add_index :posts, %i(user_id topic_id)
  end
end
