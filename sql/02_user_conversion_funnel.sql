WITH user_journey AS (
  SELECT
    user_pseudo_id,
    LOGICAL_OR(event_name = 'session_start') AS started,
    LOGICAL_OR(event_name = 'view_item') AS viewed,
    LOGICAL_OR(event_name = 'add_to_cart') AS added,
    LOGICAL_OR(event_name = 'begin_checkout') AS checkout,
    LOGICAL_OR(event_name = 'purchase') AS purchased
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND user_pseudo_id IS NOT NULL
  GROUP BY user_pseudo_id
)
SELECT
  stage,
  COUNTIF(reached) AS users
FROM user_journey,
UNNEST([
  STRUCT(1 AS stage_order, 'Session start' AS stage, started AS reached),
  STRUCT(2, 'Product view', viewed),
  STRUCT(3, 'Add to cart', added),
  STRUCT(4, 'Checkout', checkout),
  STRUCT(5, 'Purchase', purchased)
])
GROUP BY stage, stage_order
ORDER BY stage_order;
