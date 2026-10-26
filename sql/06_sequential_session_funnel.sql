WITH events AS (
  SELECT
    user_pseudo_id,
    (
      SELECT ep.value.int_value
      FROM UNNEST(event_params) AS ep
      WHERE ep.key = 'ga_session_id'
      LIMIT 1
    ) AS session_id,
    event_name,
    event_timestamp
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
    AND event_name IN (
      'session_start', 'view_item', 'add_to_cart',
      'begin_checkout', 'purchase'
    )
),
session_events AS (
  SELECT *
  FROM events
  WHERE user_pseudo_id IS NOT NULL
    AND session_id IS NOT NULL
),
step1 AS (
  SELECT
    user_pseudo_id,
    session_id,
    MIN(event_timestamp) AS start_time
  FROM session_events
  WHERE event_name = 'session_start'
  GROUP BY 1, 2
),
step2 AS (
  SELECT
    s.user_pseudo_id,
    s.session_id,
    MIN(e.event_timestamp) AS view_time
  FROM step1 s
  JOIN session_events e
    ON s.user_pseudo_id = e.user_pseudo_id
   AND s.session_id = e.session_id
   AND e.event_name = 'view_item'
   AND e.event_timestamp >= s.start_time
  GROUP BY 1, 2
),
step3 AS (
  SELECT
    s.user_pseudo_id,
    s.session_id,
    MIN(e.event_timestamp) AS cart_time
  FROM step2 s
  JOIN session_events e
    ON s.user_pseudo_id = e.user_pseudo_id
   AND s.session_id = e.session_id
   AND e.event_name = 'add_to_cart'
   AND e.event_timestamp >= s.view_time
  GROUP BY 1, 2
),
step4 AS (
  SELECT
    s.user_pseudo_id,
    s.session_id,
    MIN(e.event_timestamp) AS checkout_time
  FROM step3 s
  JOIN session_events e
    ON s.user_pseudo_id = e.user_pseudo_id
   AND s.session_id = e.session_id
   AND e.event_name = 'begin_checkout'
   AND e.event_timestamp >= s.cart_time
  GROUP BY 1, 2
),
step5 AS (
  SELECT
    s.user_pseudo_id,
    s.session_id
  FROM step4 s
  JOIN session_events e
    ON s.user_pseudo_id = e.user_pseudo_id
   AND s.session_id = e.session_id
   AND e.event_name = 'purchase'
   AND e.event_timestamp >= s.checkout_time
  GROUP BY 1, 2
)
SELECT 1 AS step_order, 'Session start' AS stage, COUNT(*) AS sessions FROM step1
UNION ALL
SELECT 2, 'Product view', COUNT(*) FROM step2
UNION ALL
SELECT 3, 'Add to cart', COUNT(*) FROM step3
UNION ALL
SELECT 4, 'Checkout', COUNT(*) FROM step4
UNION ALL
SELECT 5, 'Purchase', COUNT(*) FROM step5
ORDER BY step_order;
