class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :message
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :from_user_id

      t.timestamps
    end
  end
end
