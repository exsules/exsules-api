class Post < ApplicationRecord
  belongs_to :user
  belongs_to :source, class_name: 'User', foreign_key: :from_user_id
  belongs_to :link_crawler_cache
  has_many :comments, as: :commentable, dependent: :destroy

  validates :message, presence: true

  attr_accessor :link_crawler_url

  before_create :hashtags
  after_commit :queue_link_fetch, on: :create, if: :contains_url?

  acts_as_taggable_on :tags

  def raw_message
    self[:message]
  end

  def urls
    @urls ||= Twitter::Extractor.extract_urls(raw_message)
  end

  def hashtags
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
#  id                    :uuid             not null, primary key
#  user_id               :uuid
#  message               :text
#  likes_count           :integer          default(0)
#  comments_count        :integer          default(0)
#  from_user_id          :uuid
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  reposts_count         :integer          default(0)
#  link_crawler_cache_id :uuid
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_5b5ddfd518  (user_id => users.id)
#
