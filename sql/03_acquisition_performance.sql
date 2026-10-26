SELECT
  COALESCE(traffic_source.source, '(unknown)') AS acquisition_source,
  COALESCE(traffic_source.medium, '(unknown)') AS acquisition_medium,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNT(DISTINCT IF(event_name = 'purchase',
    user_pseudo_id, NULL)) AS purchasers,
  COUNTIF(event_name = 'purchase') AS purchases,
  ROUND(SUM(IF(event_name = 'purchase',
    COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)), 2)
    AS revenue_usd
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY 1, 2
ORDER BY revenue_usd DESC;
