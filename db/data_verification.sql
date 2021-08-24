SELECT *
FROM public.metric_events
WHERE event_type != 'impression' AND event_type != 'conversion'