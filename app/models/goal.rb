class Goal < ApplicationRecord
  belongs_to :user
  has_many :key_results, dependent: :destroy

  validates :title, :user, presence: true
end
