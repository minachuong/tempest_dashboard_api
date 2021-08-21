class User < ApplicationRecord
  validates :source_id, presence: true, uniqueness: true
end
