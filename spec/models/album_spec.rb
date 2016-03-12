RSpec.describe Album, type: :model do
  describe 'association' do
    it { should belong_to :owner }
    it { should have_many(:photos).dependent(:destroy) }
  end
end
