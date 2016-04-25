class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.string :text, null: false
      t.references :user, foreign_key: true, type: :uuid
      t.integer :likes_count, default: 0
      t.references :commentable, polymorphic: true, default: "Post", type: :uuid

      t.timestamps
    end
  end
end
