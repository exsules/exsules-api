class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :likable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end
