require 'rails_helper'

RSpec.describe KeyResult, type: :model do
  describe 'association' do
    it { should belong_to(:goal) }
    it { should belong_to(:user) }
  end

  describe 'validation' do
    it { validate_presence_of(:goal) }
    it { validate_presence_of(:title) }
    it { validate_presence_of(:status) }
  end
end
