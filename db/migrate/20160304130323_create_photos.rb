class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos, id: :uuid do |t|
      t.string :caption
      t.references :user, foreign_key: true, type: :uuid
      t.references :album, type: :uuid
      t.integer :cover, default: 0

      t.timestamps
    end
  end
end
