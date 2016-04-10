class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :caption
      t.references :user, foreign_key: true
      t.references :album
      t.integer :cover, default: 0

      t.timestamps
    end
  end
end
