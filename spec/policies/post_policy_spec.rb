require 'rails_helper'

RSpec.describe PostPolicy do

  let(:user) { Fabricate(:user) }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    it 'denies access if user is not author' do
      expect(subject).not_to permit(user, Fabricate(:post, from_user_id: Fabricate(:user)))
    end

    it 'grants access if user is the author' do
      user2 = Fabricate(:user)
      expect(subject).to permit(user2, Fabricate(:post, user: user, source: user2))
    end
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
