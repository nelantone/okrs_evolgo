require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:key_results) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user) }
  end
end
