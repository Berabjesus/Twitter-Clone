class Tweet < ApplicationRecord
  validates :tweet, presence: true
  validates :tweet, length: { minimum: 2 }
end
