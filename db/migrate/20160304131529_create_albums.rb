class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums, id: :uuid do |t|
      t.string :name
      t.references :owner, polymorphic: true, type: :uuid
      t.string :owner_type
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
