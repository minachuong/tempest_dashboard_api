class InsightsService 
  def select_insights 
    sql = "
SELECT 
  u.first_name, 
  u.last_name, 
  u.occupation, 
  u.avatar_url,
  COUNT(*) FILTER(WHERE me.event_type = 'conversion') AS total_conversions,
  COUNT(*) FILTER(WHERE me.event_type = 'impression') AS total_impressions,
  ROUND(SUM(me.revenue)) AS total_revenue,
  MIN(me.time) FILTER(WHERE me.event_type = 'conversion') AS date_start,
  MAX(me.time) FILTER(WHERE me.event_type = 'conversion') AS date_end
FROM metric_events AS me
INNER JOIN users AS u ON u.id=me.user_id
GROUP BY u.id"

    results = execute_sql(sql)
  end

#   def select_daily_conversions_by_user_id user_id
#     sql = "
# SELECT 
#   COUNT(*) AS daily_conversions,
#   (SELECT DATE_TRUNC('day', time) AS day) date
# FROM metric_events
# WHERE event_type = 'conversion' AND user_id=#{user_id}
# GROUP BY date
# ORDER BY date"

#     results = execute_sql(sql)
#   end

  def select_daily_conversions user_id
    user_id_filter = user_id == nil ? "" :  "AND user_id=#{user_id}"
    sql = "
SELECT 
  COUNT(*) AS daily_conversions,
  (SELECT DATE_TRUNC('day', time) AS day) date,
  user_id
FROM metric_events
WHERE event_type = 'conversion' #{user_id_filter}
GROUP BY user_id, date
ORDER BY user_id, date"

    results = execute_sql(sql)
    map_to_user_conversions results
  end

  private
  def execute_sql sql
    ActiveRecord::Base.connection.execute(sql)
  end

  def map_to_user_conversions results
    user_conversions = []
    previous_user_id = nil

    results.each do |result|
      if previous_user_id == nil || previous_user_id != result["user_id"]
        user_conversions.push({ 
          user_id: result["user_id"], 
          conversions: [{
            date: result["date"],
            daily_conversions: result["daily_conversions"]
          }]
        })

        previous_user_id = result["user_id"]
      else
        last_user_conversions = user_conversions[user_conversions.length - 1]
        last_user_conversions[:conversions].push({
          date: result["date"],
          daily_conversions: result["daily_conversions"]
        })
      end
    end
    
    return user_conversions
  end
end
