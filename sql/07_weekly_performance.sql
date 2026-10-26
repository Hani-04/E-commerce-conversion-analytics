WITH weekly_events AS (
  SELECT
    DATE_TRUNC(
      PARSE_DATE('%Y%m%d', event_date),
      WEEK(MONDAY)
    ) AS week_start,
    user_pseudo_id,
    event_name,
    COALESCE(
      ecommerce.purchase_revenue_in_usd, 0
    ) AS purchase_revenue
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND user_pseudo_id IS NOT NULL
)
SELECT
  week_start,
  COUNT(DISTINCT user_pseudo_id) AS active_users,
  COUNT(DISTINCT IF(
    event_name = 'purchase',
    user_pseudo_id, NULL
  )) AS purchasing_users,
  COUNTIF(event_name = 'purchase') AS purchases,
  ROUND(SUM(IF(
    event_name = 'purchase',
    purchase_revenue, 0
  )), 2) AS revenue_usd,
  ROUND(
    100 * SAFE_DIVIDE(
      COUNT(DISTINCT IF(
        event_name = 'purchase',
        user_pseudo_id, NULL
      )),
      COUNT(DISTINCT user_pseudo_id)
    ), 2
  ) AS purchaser_rate_pct
FROM weekly_events
GROUP BY week_start
ORDER BY week_start;
