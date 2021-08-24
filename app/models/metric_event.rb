class MetricEvent < ApplicationRecord
  belongs_to :user
  validates :event_type, :user_id, :time, :revenue, presence: true
  validate :type_validity

  # def get_aggregates_by_user
  #   User.all.map {|u| 
  #     { first_name: u.first_name,
  #       last_name: u.last_name,
  #       occupation: u.occupation,
  #       total_revenue: u.metric_events.sum(:revenue), 
  #       total_conversions: u.metric_events.where(event_type: 'conversion').count, 
  #       total_impressions: u.metric_events.where(event_type: 'impression').count
  #     }
  #   }
  # end

  private 
  def type_validity
    unless event_type == "impression" || event_type == "conversion"
      errors.add(:event_type, "must be of type 'impression' or 'conversion'")
    end
  end
end
