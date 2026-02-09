class Vote < ApplicationRecord
  belongs_to :team, counter_cache: true

  validates :voter_hash, presence: true, uniqueness: true
end
