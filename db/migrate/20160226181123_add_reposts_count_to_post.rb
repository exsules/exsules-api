class AddRepostsCountToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :reposts_count, :integer, default: 0
  end
end
