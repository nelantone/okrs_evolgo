class Goal < ApplicationRecord
  belongs_to :user
  has_many :key_results, dependent: :destroy

  validates :title, :user, presence: true

  def progress
    return '0%' if key_results.empty?

    result = count_complete_done_status / key_results.size
    "#{(result * 100).to_i}%"
  end

  private

  def count_complete_done_status
    all_key_results       = key_results.pluck(:status)
    only_done_key_results = all_key_results.select { |n| n == 1 }

    only_done_key_results.sum
  end
end
