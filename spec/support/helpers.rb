module Helpers
  def self.next_seq
    @next_seq = (@next_seq || 0) +1
  end

  def login(fabricator=nil)
    user = Fabricate(fabricator || :user)
    sign_in(user)
    request.headers.merge!(user.create_new_auth_token)
  end
end
