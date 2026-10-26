SELECT
  device.category AS device_category,
  geo.country AS country,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNT(DISTINCT IF(
    event_name = 'purchase',
    user_pseudo_id, NULL
  )) AS purchasing_users,
  COUNTIF(event_name = 'purchase') AS purchases,
  ROUND(SUM(
    IF(event_name = 'purchase',
       COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)
  ), 2) AS revenue_usd,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNT(DISTINCT IF(
        event_name = 'purchase',
        user_pseudo_id, NULL
      )),
      COUNT(DISTINCT user_pseudo_id)
    ), 2
  ) AS purchaser_rate_pct
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
  AND user_pseudo_id IS NOT NULL
GROUP BY 1, 2
ORDER BY revenue_usd DESC;
