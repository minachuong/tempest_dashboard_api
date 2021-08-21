class MetricEvent < ApplicationRecord
  belongs_to :user
  # validates :event_type, :user_id, :time, :revenue, presence: true
  # validate :type_validity

  private 
  def type_validity
    unless event_type == "impression" || event_type == "conversion"
      errors.add(:event_type, "must be of type 'impression' or 'conversion'")
    end
  end

end
