require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
    create(:goal, title: 'new goal 1', user: @user)
    create(:goal, title: 'new goal 2', user: @user)
    create(:goal, title: 'new goal 3', user: @user)
  end

  describe 'association' do
    it { should have_many(:goals) }
    it { should have_many(:key_results) }
  end

  describe 'validations' do
    it { should validate_presence_of(:owner) }
  end

  describe 'A user' do
    it 'gets the list of all owned goals' do
      expect(@user.goals.size).to eq(3)
    end
  end
end
