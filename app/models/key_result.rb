class KeyResult < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :title, presence: true

  validates :status, inclusion: { in: [0.0, 0.5, 1.0],
                                  message: "%{value} is not a valid number, please select: `0` as 'not started', `0.5` as “in progress”, or
  `1` as “completed”" }
end
