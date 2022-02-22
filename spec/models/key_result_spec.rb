require 'rails_helper'

RSpec.describe KeyResult, type: :model do
  before do
    @key_result = create(:key_result)
  end

  describe 'association' do
    it { should belong_to(:goal) }
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it { validate_presence_of(:goal) }
    it { validate_presence_of(:title) }
    it { validate_presence_of(:status) }
  end

  describe 'A key-result' do
    it 'can be created by the user' do
      expect(@key_result).to be_valid
    end

    it 'has an owner (user who created it by default)' do
      expect(@key_result.user.owner).to eq('Who? Me?')
    end

    it 'has a title' do expect(@key_result.title).to eq('Test key-results') end
    it 'has a status' do expect(@key_result.status).to eq(0) end
  end
end
