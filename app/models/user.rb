class User < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_many :key_results, through: :goals

  validates :owner, presence: true
end
