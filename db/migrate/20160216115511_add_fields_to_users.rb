class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :username_lower, :string, null: false
    add_column :users, :initial_setup, :boolean, default: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :sex, :integer, default: 0
    add_column :users, :location, :string
    add_column :users, :bio, :string, limit: 128
    add_column :users, :birthday, :date
    add_column :users, :posts_count, :integer, default: 0
    add_column :users, :role, :integer, default: 0
    add_column :users, :disable_mail, :boolean, default: false
    add_column :users, :preferences, :jsonb, null: false, default: '{}'

    add_index :users, :preferences, using: :gin
  end
end
