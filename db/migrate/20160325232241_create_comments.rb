class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.references :user, foreign_key: true
      t.integer :likes_count, default: 0
      t.references :commentable, polymorphic: true, default: "Post"

      t.timestamps
    end
  end
end
