require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    it { should have_many(:goals) }
    it { should have_many(:key_results) }
  end

  describe 'validations' do
    it { should validate_presence_of(:owner) }
  end
end
