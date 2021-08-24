SELECT 
  COUNT(*) AS daily_conversion,
  (SELECT DATE_TRUNC('day', time) AS day) d
FROM metric_events
WHERE event_type = 'conversion' AND user_id=
GROUP BY d
ORDER BY d