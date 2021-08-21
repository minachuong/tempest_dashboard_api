class User < ApplicationRecord
  validates :first_name, :last_name, :avatar_url, presence: true
  has_many :metric_events
end
