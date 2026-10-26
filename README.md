# E-commerce Conversion & Acquisition Analytics
E-commerce conversion, acquisition and marketing performance analysis using BigQuery SQL and Tableau.

**BigQuery SQL | Google Analytics 4 | Tableau | Commercial Analytics**

## Overview

An end-to-end analysis of e-commerce acquisition performance, customer purchasing behaviour, and conversion efficiency using Google's public GA4 e-commerce dataset.

The project examines customer acquisition, conversion bottlenecks, and marketing performance to support data-driven commercial decisions.

## Dataset

- **Source:** Google Merchandise Store (BigQuery public dataset)
- **Period:** November 2020 – January 2021
- **Dataset:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce`
- **Tools:** BigQuery SQL, Tableau Public, GitHub

The dataset contains obfuscated event-level e-commerce data.

## Key Findings

### 1. Acquisition Performance

| Acquisition Source | Revenue (USD) |
|---|---:|
| Google Organic | $95,775 |
| Direct | $79,650 |
| Google CPC | $9,056 |

Organic search generated the highest recorded revenue among these channels.

However, revenue alone does not establish profitability without advertising expenditure.

### 2. Purchase Conversion Rates

| Channel | Purchaser Rate |
|---|---:|
| Referral | 1.76% |
| Organic Search | 1.17% |
| Paid Search (CPC) | 0.98% |

These figures represent the proportion of acquired users who made at least one purchase during the analysis period.

They are not session-based conversion rates.

### 3. Sequential Session Conversion Funnel

An ordered, session-level analysis identified the following progression:

| Stage | Sessions |
|---|---:|
| Session Start | 354,857 |
| Product View | 75,264 |
| Add to Cart | 14,892 |
| Begin Checkout | 5,325 |
| Purchase | 2,802 |

**Stage-to-stage drop-off rates:**

| Transition | Drop-off |
|---|---:|
| Session Start → Product View | 78.8% |
| Product View → Add to Cart | 80.2% |
| Add to Cart → Checkout | 64.2% |
| Checkout → Purchase | 47.4% |

Of the 5,325 sessions reaching checkout in the defined sequence, approximately **52.6% completed a purchase**.

## Advertising Economics: Illustrative Scenario

A separate scenario explores how advertising expenditure influences key performance metrics.

### Assumptions

| Variable | Value |
|---|---:|
| Recorded Google CPC Revenue | $9,056 |
| Assumed Advertising Spend | $4,500 |
| Assumed Clicks | 9,000 |

### Calculated Metrics

| Metric | Formula | Result |
|---|---|---:|
| Cost per Click (CPC) | Spend / Clicks | $0.50 |
| Cost per Purchase | Spend / Purchases | $27.11 |
| Return on Ad Spend (ROAS) | Revenue / Spend | 2.01x |

**Important:** Advertising spend and click counts are hypothetical. These calculations demonstrate marketing performance metrics and do not represent measured campaign profitability.

### Budget Sensitivity Analysis

The sensitivity analysis evaluates illustrative advertising expenditure levels of $3,000, $4,500, $6,000, $7,500, and $9,000.

Recorded revenue is held constant while assumed expenditure varies.

This demonstrates the mathematical relationship between advertising spend and ROAS, not the expected outcome of changing real campaign budgets.

## Commercial Insights & Recommendations

### Acquisition Strategy

Organic search generated substantial recorded revenue. Further investigation should compare acquisition efficiency across channels using actual advertising costs, traffic quality, and customer behaviour.

### Conversion Optimisation

The sequential funnel identifies substantial reductions between product views and add-to-cart events, as well as between basket additions and checkout initiation.

Potential explanations include product-page effectiveness, pricing, delivery costs, and checkout friction.

These are hypotheses requiring additional evidence.

### Experimentation

Recommended next steps include:

- Investigating conversion differences across acquisition channels.
- Analysing landing-page and product-page performance.
- Evaluating checkout usability and payment friction.
- Running controlled A/B tests to validate proposed improvements.
- Incorporating actual campaign expenditure to assess marketing efficiency.

## SQL Analysis

The [`sql/`](sql/) directory contains six documented queries:

| File | Description |
|---|---|
| `01_event_exploration.sql` | Event frequencies and unique-user counts |
| `02_user_conversion_funnel.sql` | User-level purchasing-stage participation |
| `03_acquisition_performance.sql` | Acquisition sources, purchasers, and revenue |
| `04_paid_search_roas_scenario.sql` | Illustrative CPC, cost per purchase, and ROAS |
| `05_budget_sensitivity.sql` | ROAS sensitivity under hypothetical spending assumptions |
| `06_sequential_session_funnel.sql` | Ordered session-level purchasing funnel |

## Tableau Dashboard

**Interactive Dashboard:** Link to be added after final publication.

The Tableau dashboard includes:

- Revenue by acquisition source
- Purchase conversion rates by channel
- User-level customer journey
- Sequential session conversion funnel
- Illustrative paid-search performance KPIs
- Advertising expenditure sensitivity analysis

## Methodology & Limitations

1. The analysis uses Google's public, obfuscated GA4 e-commerce sample dataset.
2. Acquisition categories use first-user traffic source and medium.
3. User-level event participation is not equivalent to sequential funnel progression.
4. The sequential funnel tracks events in chronological order within individual GA4 sessions.
5. Sessions without usable session identifiers are excluded.
6. Observed channel performance does not establish causation.
7. Advertising expenditure and clicks are hypothetical scenario inputs.
8. ROAS and cost metrics derived from those assumptions are illustrative, not actual campaign results.

## Skills Demonstrated

- Advanced SQL and Common Table Expressions (CTEs)
- Google BigQuery
- GA4 event-level data analysis
- Customer conversion funnel modelling
- Marketing acquisition analysis
- Tableau dashboard development
- Commercial KPI analysis
- ROAS, CPC, and acquisition-cost modelling
- Analytical reporting and business recommendations
