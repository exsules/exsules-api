module Helpers
  def self.next_seq
    @next_seq = (@next_seq || 0) +1
  end

  def login(fabricator=nil)
    user = Fabricate(fabricator || :user)
    auth_headers = user.create_new_auth_token

    token = auth_headers['access-token']
    client_id = auth_headers['client']
    expiry = auth_headers['expiry']
  end
end
