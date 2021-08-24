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

    results = ActiveRecord::Base.connection.execute(sql)
  end

  def select_daily_conversions_by_user_id user_id
    sql = "
SELECT 
  COUNT(*) AS daily_conversions,
  (SELECT DATE_TRUNC('day', time) AS day) date
FROM metric_events
WHERE event_type = 'conversion' AND user_id=#{user_id}
GROUP BY date
ORDER BY date"

    results = ActiveRecord::Base.connection.execute(sql)
  end

end
