class KeyResult < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :title, presence: true
end
