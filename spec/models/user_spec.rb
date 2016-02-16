require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:photos).dependent(:destroy) }
    it { should have_many(:albums).dependent(:destroy) }
  end

  describe 'validation' do
    let(:user) { Fabricate(:user) }

    describe 'of username' do
      it 'requires presence' do
        user.username = nil
        expect(user.save).to be false
      end

      it 'requires downcase' do
        user = Fabricate.build(:user, username: 'RandOMUsername')
        user.save
        expect(user.username_lower).to eq ("randomusername")
      end

      it 'strips whitespaces' do
        user = Fabricate.build(:user, username: '   username   ')
        user.save
        expect(user.username).to eq('username')
      end

      it 'strips and downcases username_lower' do
        user = Fabricate.build(:user, username: '    USerNAME    ')
        user.save
        expect(user.username_lower).to eq('username')
      end

      it 'should be atleast 3 chars' do
        user.username = 'aa'
        expect(user.save).to be false
      end

      it 'can be 30 characters long' do
        user.username = 'a' * 30
        expect(user).to be_valid
      end

      it 'can not be 31 characters long' do
        user.username = 'a' * 31
        expect(user).to be_invalid
      end

      it 'should never end with a dot' do
        user.username = 'Bjorn.'
        expect(user).to be_invalid
      end

      %w(
        Bad\ Name
        Other%bad
        with!
        @username
        sh
        dontwork$
        my@email.com
        bjorn.json
        bjorn.html
        bjorn.htm
        bjorn.js
        bjorn.gif
      ).each do |bad_username|
        it "should not allow #{bad_username}" do
          user.username = bad_username
          expect(user).to be_invalid
        end
      end
    end

    describe 'of email' do
      it 'requires presence' do
        user.email = nil
        expect(user).to be_invalid
      end

      it 'requires a valid email address' do
        user.email = "email@email"
        expect(user).to be_invalid
      end

      %w(
        mail@mail@example.com
        .mail@example.com
        mail.@example.com
        .mail.@example.com
      ).each do |bad_email|
        it "should not allow #{bad_email}" do
          user.email = bad_email
          expect(user).to be_invalid
        end
      end

      it 'downcases email' do
        user = Fabricate.create(:user, email: "eMAIl@EXAmple.coM")
        user.save
        expect(user.email).to eq("email@example.com")
      end

      it 'strips whitespaces' do
        user = Fabricate.create(:user, email: '       mail@example.com     ')
        user.save
        expect(user.email).to eq("mail@example.com")
      end
    end

    describe '.find_by_username_or_email' do
      it 'finds the right user' do
        bjorn = Fabricate.create(:user, username: 'bjorn', email: 'bjorn@dog.com')
        user = User.find_by_username_or_email('bjorn')
        expect(user).to eq bjorn

        user = User.find_by_username_or_email('Bjorn')
        expect(user).to eq bjorn

        user = User.find_by_username_or_email('bjorn@dog.com')
        expect(user).to eq bjorn

        user = User.find_by_username_or_email('BJORN@dog.com')
        expect(user).to eq bjorn

        user = User.find_by_username_or_email('not_bjorn')
        expect(user).to eq nil
      end
    end
  end
end
