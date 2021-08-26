class InsightsService 
  def select_insights 
    sql = "
SELECT 
  u.id AS user_id,
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
    map_summary_results_to_insight_summaries results
  end

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
    map_conversion_results_to_user_conversions results
  end

  private
  def execute_sql sql
    ActiveRecord::Base.connection.execute(sql)
  end

  def map_conversion_results_to_user_conversions results
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

  def map_summary_results_to_insight_summaries results
    results.map do |result| 
      { 
        user: 
          {
            id: result["user_id"],
            first_name: result["first_name"],
            last_name: result["last_name"],
            occupation: result["occupation"],
            avatar_url: result["avatar_url"]
          },
        total_conversions: result["total_conversions"],
        total_impressions: result["total_impressions"],
        total_revenue: result["total_revenue"],
        date_start: result["date_start"],
        date_end: result["date_end"]
      }
    end
  end
end
