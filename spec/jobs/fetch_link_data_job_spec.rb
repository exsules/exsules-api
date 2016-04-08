require 'rails_helper'

RSpec.describe FetchLinkDataJob, type: :job do
  include ActiveJob::TestHelper
  let(:post) { Fabricate(:post) }

  before do
    @title = 'Homepage'
    @type = 'website'
    @image = 'http://example.com/img/image.png'
    @url = 'http://example.com'
    @description = 'Homepage description'

    @body =
      "<html><head><title>#{@title}</title>
      <meta property=\"og:title\" content=\"#{@title}\"/>
      <meta property=\"og:type\" content=\"#{@type}\"/>
      <meta property=\"og:image\" content=\"#{@image}\"/>
      <meta property=\"og:url\" content=\"#{@url}\"/>
      <meta property=\"og:description\" content=\"#{@description}\"/>
      </head><body></body></html>"

    stub_request(:head, @url).
      with(:headers => {'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(status: 200, body: "", headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:get, @url).
      with(:headers => {'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(status: 200, body: @body, headers: {'Content-Type' => 'text/html; utf-8'})
  end

  describe '.perform' do
    it 'requests data from internet' do
      pending 'need fix'
      FetchLinkDataJob.perform_now(post.id, @url)

      expect(a_request(:get, @url)).to have_been_made
    end
  end

end
