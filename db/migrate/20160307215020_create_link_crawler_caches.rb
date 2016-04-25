class CreateLinkCrawlerCaches < ActiveRecord::Migration[5.0]
  def up
    create_table :link_crawler_caches, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :url

      t.timestamps
    end

    change_table :posts do |t|
      t.uuid :link_crawler_cache_id
    end
  end

  def down
    remove_column :posts, :link_crawler_cache_id
    drop_table :link_crawler_caches
  end
end
