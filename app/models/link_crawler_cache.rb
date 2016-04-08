class LinkCrawlerCache < ApplicationRecord
  has_many :posts

  validates :title, presence: true
  validates :image, presence: true
  validates :url, presence: true

  def self.find_or_create_by(opts)
    cache = LinkCrawlerCache.find_or_initialize_by(opts)
    cache.fetch_link_data! unless cache.persisted?
    cache if cache.persisted?
  end

  def fetch_link_data!
    object = LinkThumbnailer.generate(self.url)

    return unless object

    self.title = object.title
    self.image = object.images.first.try(:src).to_s
    self.url = object.url
    self.description = object.description

    self.save
  end
end

# == Schema Information
#
# Table name: link_crawler_caches
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
#  image       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
