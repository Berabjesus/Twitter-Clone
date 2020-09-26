# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  validates :tweet, presence: true
  validates :tweet, length: { minimum: 2 }
end
