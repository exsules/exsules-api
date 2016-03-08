class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.text :message
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.uuid :from_user_id

      t.timestamps
    end
  end
end
