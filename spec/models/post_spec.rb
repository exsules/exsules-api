RSpec.describe Post, type: :model do
  describe 'association' do
    it { should belong_to :user }
    it {
      should belong_to(:source).
      class_name('User').
      with_foreign_key(:from_user_id)
    }
  end

  describe 'validation' do
    let(:post) { Fabricate(:post) }

    describe 'of message' do
      it 'requires presence' do
        post.message = nil
        expect(post).to be_invalid
      end
    end
  end
end
