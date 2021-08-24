SELECT 
	u.first_name, 
	u.last_name, 
	u.occupation, 
	COUNT(*) FILTER(WHERE me.event_type = 'conversion') AS total_conversions,
	COUNT(*) FILTER(WHERE me.event_type = 'impression') AS total_impressions,
	ROUND(SUM(me.revenue)) AS total_revenue,
  MIN(me.time) FILTER(WHERE me.event_type = 'conversion') AS date_start,
  MAX(me.time) FILTER(WHERE me.event_type = 'conversion') AS date_end
FROM metric_events AS me
INNER JOIN users AS u ON u.id=me.user_id
GROUP BY u.id