class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.references :owner, polymorphic: true
      t.string :owner_type
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
