class FetchLinkDataJob < ApplicationJob
  queue_as :http_service

  def perform(post_id, url, retry_count=1)
    post = Post.find(post_id)
    post.link_crawler_cache = LinkCrawlerCache.find_or_create_by(url: url)
    post.save
  rescue ActiveRecord::RecordNotFound
    FetchLinkDataJob.set(wait: 1.minute).
      perform_later(post_id, url, retry_count+1) unless retry_count > 3
  rescue LinkThumbnailer::Exceptions
    FetchLinkDataJob.set(wait: 1.minute).
      perform_later(post_id, url, retry_count+1) unless retry_count > 3
  end
end
