require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:key_results) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user) }
  end

  describe 'A goal' do
    it 'can be created by the user' do
      expect(goal).to be_valid
    end

    it 'has an owner (user who created it by default)' do
      expect(goal.user.owner).to eq('Who? Me?')
    end

    it 'has a title' do expect(goal.title).to eq('Test my app') end
    it 'has a start date' do expect(goal.start_date).to eq('2022-02-02 02:22') end
    it 'has an end date' do expect(goal.end_date).to eq('2022-02-03 02:22') end
  end

  describe 'progress is decided by the status of its key results' do
    it 'has 2 key results and both are “completed” the progress is 100%' do
      user2     = create(:user, owner: 'super user')
      goal_done = create(:goal, user: user2)

      create(:key_result, goal: goal_done, user: user2, status: 1, title: 'first goal done')
      create(:key_result, goal: goal_done, user: user2, status: 1, title: 'second goal done')
      expect(goal_done.progress).to eq('100%')
    end

    it 'has  2 key results and 1 is “completed” the progress is 50%' do
      user3     = create(:user, owner: 'super user')
      half_goal = create(:goal, user: user3)

      create(:key_result, goal: half_goal, user: user3, status: 1, title: 'first goal done')
      create(:key_result, goal: half_goal, user: user3, status: 0.5, title: 'second goal done')
      expect(half_goal.progress).to eq('50%')
    end

    it 'has 2 key started results and none of them are completed the progress
    is 0 %' do
      user4         = create(:user, owner: 'super user')
      non_done_goal = create(:goal, user: user4)

      create(:key_result, goal: non_done_goal, user: user4, status: 0.5, title: 'first goal done')
      create(:key_result, goal: non_done_goal, user: user4, status: 0.5, title: 'second goal done')
      expect(non_done_goal.progress).to eq('0%')
    end

    it 'has 1 key started result and one non started. None of them are completed the progress
    is 0 %' do
      user5         = create(:user, owner: 'super user')
      non_done_goal = create(:goal, user: user5)

      create(:key_result, goal: non_done_goal, user: user5, status: 0.5, title: 'first goal done')
      create(:key_result, goal: non_done_goal, user: user5, status: 0, title: 'second goal done')
      expect(non_done_goal.progress).to eq('0%')
    end

    it 'is also considered zero percent, if a goal does not have any key
result associated with it.' do
      user6         = create(:user, owner: 'super user')
      non_done_goal = create(:goal, user: user6)

      expect(non_done_goal.progress).to eq('0%')
    end
  end
end
