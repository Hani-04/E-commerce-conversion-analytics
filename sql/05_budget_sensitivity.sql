WITH scenarios AS (
  SELECT 3000 AS ad_spend_usd UNION ALL
  SELECT 4500 UNION ALL
  SELECT 6000 UNION ALL
  SELECT 7500 UNION ALL
  SELECT 9000
)
SELECT
  ad_spend_usd,
  9056 AS revenue_usd,
  166 AS purchases,
  ROUND(9056 / ad_spend_usd, 2) AS roas,
  ROUND(ad_spend_usd / 166, 2) AS cost_per_purchase
FROM scenarios
ORDER BY ad_spend_usd;
