class Post < ApplicationRecord
  belongs_to :user
  belongs_to :source, class_name: 'User', foreign_key: :from_user_id
  belongs_to :link_crawler_cache

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  validates :message, presence: true

  attr_accessor :link_crawler_url

  after_create :extract_hashtags
  after_commit :queue_link_fetch, on: :create, if: :contains_url?

  acts_as_taggable_on :tags

  def raw_message
    self[:message]
  end

  def urls
    @urls ||= Twitter::Extractor.extract_urls(raw_message)
  end

  def extract_hashtags
    @hashtags ||= Twitter::Extractor.extract_hashtags(raw_message)
    @hashtags.each {|hash| self.tag_list.add(hash)}
  end

  def contains_url?
    self.link_crawler_url = self.urls[0]
  end

  def queue_link_fetch
    FetchLinkDataJob.perform_later(self.id, self.link_crawler_url)
  end
end

# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  message               :text
#  likes_count           :integer          default(0)
#  comments_count        :integer          default(0)
#  from_user_id          :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  reposts_count         :integer          default(0)
#  link_crawler_cache_id :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_5b5ddfd518  (user_id => users.id)
#
