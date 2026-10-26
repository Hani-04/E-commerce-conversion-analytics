WITH paid_search AS (
  SELECT
    'Google CPC' AS channel,
    COUNT(DISTINCT IF(event_name = 'purchase',
      user_pseudo_id, NULL)) AS purchasers,
    COUNTIF(event_name = 'purchase') AS purchases,
    ROUND(SUM(IF(event_name = 'purchase',
      COALESCE(ecommerce.purchase_revenue_in_usd, 0), 0)), 2) AS revenue_usd
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND traffic_source.source = 'google'
    AND traffic_source.medium = 'cpc'
),
scenario AS (
  SELECT
    *,
    4500.0 AS assumed_ad_spend_usd,
    9000 AS assumed_clicks
  FROM paid_search
)
SELECT
  *,
  ROUND(assumed_ad_spend_usd / assumed_clicks, 2) AS cpc_usd,
  ROUND(assumed_ad_spend_usd / NULLIF(purchases, 0), 2)
    AS cost_per_purchase_usd,
  ROUND(revenue_usd / NULLIF(assumed_ad_spend_usd, 0), 2)
    AS roas_multiple,
  ROUND(100 * revenue_usd / NULLIF(assumed_ad_spend_usd, 0), 1)
    AS roas_percent
FROM scenario;
