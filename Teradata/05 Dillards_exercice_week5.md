# Week 5 Exercises

## Exercise 1

How many distinct dates are there in the saledate column of the transaction
table for each **month/year** combination in the database?

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  dates.yr,
  dates.mon,
  count(dy) AS dayCount
FROM
  (
    SELECT
      EXTRACT(
        Year
        FROM
          saledate
      ) AS Yr,
      EXTRACT(
        MONTH
        FROM
          saledate
      ) AS mon,
      EXTRACT(
        DAY
        FROM
          saledate
      ) AS dy
    FROM
      trnsact
    GROUP BY
      dy,
      mon,
      yr
  ) AS dates
GROUP BY
  dates.yr,
  dates.mon
ORDER BY
  dates.yr ASC,
  dates.mon ASC;
```

</details>
&nbsp;

Query Result:

|Yr  |mon|dayCount|
|----|---|--------|
|2004|8  |31      |
|2004|9  |30      |
|2004|10 |31      |
|2004|11 |29      |
|2004|12 |30      |
|2005|1  |31      |
|2005|2  |28      |
|2005|3  |30      |
|2005|4  |30      |
|2005|5  |31      |
|2005|6  |30      |
|2005|7  |31      |
|2005|8  |27      |

&nbsp;

## Exercise 2

Use a `CASE` statement within an aggregate function to determine which sku
had the greatest total sales during the combined summer months of June, July, and August.

`CASE` statements can be used with aggregate functions. For example, if you wanted to
find the greatest (or latest) _saledate_ in December, you could write:

```SQL
MAX(CASE WHEN EXTRACT(MONTH from saledate)=12
 THEN saledate
 END) AS last_day_in_Dec
```

To determine the _sku_ that had the greatest combined total sales during the summer months, make one `CASE` statement that sums up all the sales in June, another that sums up all the sales in July, and a third that sums up all the sales in August. Then include another field in your `SELECT` statement that adds those 3 numbers together. Group your output by _sku_, and sort the output by the derived field that adds the revenue from the 3 months together. Don’t forget to restrict your sales transaction types to purchases.

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT TOP 5
  sales_by_month.sku,
  sum(sales_by_month.amount) AS sales_amount
FROM
  (
    SELECT
      EXTRACT(
        MONTH
        FROM
          saledate
      ) AS mon,
      sku,
      sum(amt) AS amount
    FROM
      trnsact
    WHERE
      stype = 'P'
      AND (
        mon = 6
        OR mon = 7
        OR mon = 8
      )
    GROUP BY
      mon,
      sku
  ) AS sales_by_month
GROUP BY
  sales_by_month.sku
ORDER BY
  sales_amount DESC;
```

</details>
&nbsp;

Query Result:

|SKU    |sales_amount|
|-------|------------|
|4108011|1646017.38  |
|3524026|1464189.00  |
|5528349|1315121.00  |
|3978011|1055862.47  |
|2783996|897807.01   |

&nbsp;

## Exercise 3

How many distinct dates are there in the _saledate_ column of the transaction table **for each month/year/store combination** in the database? Sort your results by the
number of days per combination in ascending order.

You will see there are many month/year/store combinations that only have one day of transaction data stored in the database. In real life, this phenomenon could be a result of data being deleted, Dillard’s stores closing during the year of 2004-2005, or data being entered in error. In our case, it may simply be the result of Dillard's removing some data before donating it. We will need to take these missing data into account in many of our future analyses, especially analyses that aim to compare sales trends within subsets of stores. Start thinking about how you would examine the properties of month/year/store combinations that have a specific minimum number of days of data.

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  dates_by_store.store,
  dates_by_store.yr,
  dates_by_store.mon,
  count(dy) AS dayCount
FROM
  (
    SELECT
      EXTRACT(
        Year
        FROM
          t.saledate
      ) AS Yr,
      EXTRACT(
        MONTH
        FROM
          t.saledate
      ) AS mon,
      EXTRACT(
        DAY
        FROM
          t.saledate
      ) AS dy,
      t.store
    FROM
      trnsact t
      JOIN store_msa s ON t.store = s.store
    GROUP BY
      dy,
      mon,
      yr,
      t.store
  ) AS dates_by_store
GROUP BY
  dates_by_store.store,
  dates_by_store.yr,
  dates_by_store.mon
ORDER BY
  dayCount
```

</details>
&nbsp;

Query Result:

|STORE|Yr  |mon|dayCount|
|-----|----|---|--------|
|8304 |2004|8  |1       |
|8304 |2005|3  |1       |
|9906 |2004|8  |1       |
|7604 |2005|7  |1       |
|4402 |2004|9  |1       |
|7203 |2004|8  |3       |
|6402 |2005|3  |11      |
|5703 |2005|4  |16      |
|3002 |2005|3  |16      |
|1804 |2004|12 |17      |

&nbsp;

## Exercise 4

What is the average daily revenue for each store/month/year combination in
the database? Calculate this by dividing the total revenue for a group by the number of
sales days available in the transaction table for that group.

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  monthly_revenue_by_store.store,
  monthly_revenue_by_store.yr,
  monthly_revenue_by_store.mon,
  count(dates_by_store.dy) AS dayCount,
  monthly_revenue_by_store.amount AS revenue,
  (monthly_revenue_by_store.amount) / (count(dates_by_store.dy)) AS avg_daily_revenue
FROM
  (
    SELECT
      EXTRACT(
        Year
        FROM
          t.saledate
      ) AS Yr,
      EXTRACT(
        MONTH
        FROM
          t.saledate
      ) AS mon,
      EXTRACT(
        DAY
        FROM
          t.saledate
      ) AS dy,
      t.store
    FROM
      trnsact t
      JOIN store_msa s ON t.store = s.store
    WHERE
      stype = 'P'
      AND (
        yr <> 2005
        AND mon <> 8
      )
    GROUP BY
      dy,
      mon,
      yr,
      t.store
  ) AS dates_by_store
  INNER JOIN (
    SELECT
      EXTRACT(
        Year
        FROM
          t.saledate
      ) AS Yr,
      EXTRACT(
        MONTH
        FROM
          t.saledate
      ) AS mon,
      t.store,
      SUM(t.amt) AS amount
    FROM
      trnsact t
      JOIN store_msa s ON t.store = s.store
    WHERE
      stype = 'P'
      AND (
        yr <> 2005
        AND mon <> 8
      )
    GROUP BY
      mon,
      yr,
      t.store
  ) AS monthly_revenue_by_store ON dates_by_store.store = monthly_revenue_by_store.store
  AND dates_by_store.yr = monthly_revenue_by_store.yr
  AND dates_by_store.mon = monthly_revenue_by_store.mon
GROUP BY
  monthly_revenue_by_store.store,
  monthly_revenue_by_store.yr,
  monthly_revenue_by_store.mon,
  revenue
HAVING
  dayCount >= 20
ORDER BY
  avg_daily_revenue DESC

```

</details>

Query Result:

|STORE|Yr  |mon|dayCount|revenue   |avg_daily_revenue|
|-----|----|---|--------|----------|-----------------|
|8402 |2004|12 |30      |3152448.34|105081.61        |
|504  |2004|12 |30      |2724376.37|90812.55         |
|2707 |2004|12 |30      |2711980.93|90399.36         |
|1607 |2004|12 |30      |2595369.01|86512.30         |
|9103 |2004|12 |30      |2437700.70|81256.69         |

&nbsp;

## Exercise 5

What is the average daily revenue brought in by Dillard’s stores in areas of high, medium, or low levels of high school education?
Define areas of “low” education as those that have high school graduation rates between 50-60%, areas of “medium” education as those that have high school graduation rates between 60.01-70%, and areas of “high” education as those that have high school graduation rates of above 70%.

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  (
    CASE
      WHEN m.msa_high > 50
      AND m.msa_high <= 60 THEN 'low'
      WHEN m.msa_high > 60.01
      AND m.msa_high <= 70 THEN 'medium'
      WHEN m.msa_high > 70 THEN 'high'
    END
  ) AS education_level,
  SUM(daily_total_revenue) / SUM(transact.num_days) AS daily_revenue
FROM
  (
    SELECT
      COUNT(DISTINCT saledate) AS num_days,
      (
        EXTRACT(
          MONTH
          FROM
            saledate
        )
      ) AS months,
      (
        EXTRACT(
          YEAR
          FROM
            saledate
        )
      ) AS years,
      store,
      SUM(amt) AS daily_total_revenue,
      (
        CASE
          WHEN EXTRACT(
            MONTH
            FROM
              saledate
          ) = 8
          AND EXTRACT(
            YEAR
            FROM
              saledate
          ) = 2005 THEN 'August 2005'
        END
      ) AS month_years
    FROM
      trnsact
    GROUP BY
      months,
      years,
      store,
      month_years
    WHERE
      stype = 'P'
      AND month_years IS NULL
      AND EXTRACT(
        MONTH
        FROM
          saledate
      ) || EXTRACT(
        YEAR
        FROM
          saledate
      ) || store IN (
        SELECT
          EXTRACT(
            MONTH
            FROM
              saledate
          ) || EXTRACT(
            YEAR
            FROM
              saledate
          ) || store AS month_year_store
        FROM
          trnsact
        GROUP BY
          month_year_store
        HAVING
          COUNT(DISTINCT saledate) >= 20
      )
  ) AS transact
  JOIN store_msa m ON transact.store = m.store
GROUP BY
  education_level
ORDER BY
  daily_revenue DESC,
  education_level;

```

</details>

Query Result:

|education_level|daily_revenue|
|---------------|-------------|
|low            |34159.76     |
|medium         |25037.89     |
|high           |20937.31     |

&nbsp;

## Exercise 6

Compare the average daily revenues of the stores with the highest median msa_income and the lowest median msa_income. In what city and state were these stores, and which store had a higher average daily revenue?

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  store_info.store,
  store_info.msa_income,
  store_info.city,
  store_info.state,
  sum(store_info.tot_revenue) / sum(store_info.date_count) AS avg_revenue
FROM
  (
    SELECT
      s.store,
      s.msa_income,
      s.state,
      s.city,
      COUNT(DISTINCT t.saledate) AS date_count,
      SUM(t.amt) AS tot_revenue
    FROM
      store_msa AS s
      INNER JOIN (
        SELECT
          min(msa_income) AS min_income,
          max(msa_income) AS max_income
        FROM
          store_msa
      ) AS mm ON (
        s.msa_income = mm.min_income
        OR s.msa_income = mm.max_income
      )
      INNER JOIN trnsact AS t ON t.store = s.store
    WHERE
      t.stype = 'P'
      AND (
        EXTRACT(
          YEAR
          FROM
            t.saledate
        ) <> 2005
        OR EXTRACT(
          MONTH
          FROM
            t.saledate
        ) <> 8
      )
    GROUP BY
      s.store,
      s.state,
      s.city,
      s.msa_income
  ) AS store_info
WHERE
  store_info.date_count >= 20
GROUP BY
  store_info.store,
  store_info.msa_income,
  store_info.city,
  store_info.state;
```

</details>

Query Result:

|STORE|MSA_INCOME|CITY                                    |STATE|avg_revenue|
|-----|----------|----------------------------------------|-----|-----------|
|3902 |56099     |SPANISH FORT                            |AL   |17884.08   |
|2707 |16022     |MCALLEN                                 |TX   |56601.99   |

&nbsp;

## Exercise 7

What is the brand of the sku with the greatest standard deviation in sprice? Only examine skus that have been part of over 100 sales transactions.

&nbsp;

```SQL
SELECT
  TOP 5 s.sku,
  s.brand,
  AVG(t.sprice) AS average_price,
  STDDEV_SAMP(t.sprice) AS standard_deviation,
  COUNT(t.trannum) AS transactions
FROM
  skuinfo s
  JOIN trnsact t ON s.sku = t.sku
GROUP BY
  1,
  2
HAVING
  COUNT(t.trannum) > 100
ORDER BY
  STDDEV_SAMP(t.sprice) DESC;

```

Query Result:

|SKU    |BRAND             |average_price     |standard_deviation|transactions|
|-------|------------------|------------------|------------------|------------|
|3733090|CABERNET          |11.487134652201659|178.56885261120678|1567        |
|2762683|HART SCH          |335.7418918918919 |175.85294108489174|111         |
|5453849|POLO FAS          |286.67936781609194|170.5073654790206 |348         |
|5623849|POLO FAS          |256.969298245614  |167.50716973395694|228         |
|4213926|POLO FAS          |250.80502857142858|156.5698185631986 |175         |

&nbsp;

## Exercise 8

Examine all the transactions for the sku with the greatest standard deviation in sprice (ie, your answer to exercise 7) Do you think the original sale price was set to be too high, or was just right?

```SQL
SELECT * FROM trnsact WHERE sku = '3733090' ORDER BY sprice DESC
```

The price was right, there were just 2 transactions that were highly irregular.

&nbsp;

## Exercise 9

What was the average daily revenue Dillard’s brought in during each month of
the year?

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  YearMonth,
  SUM(rev) / sum(datenum) as average_revenue
FROM
  (
    SELECT
      EXTRACT(
        YEAR
        FROM
          saledate
      ) || EXTRACT(
        MONTH
        FROM
          saledate
      ) AS YearMonth,
      store,
      SUM(amt) AS rev,
      COUNT(DISTINCT saledate) AS datenum
    FROM
      trnsact
    WHERE
      saledate < '2005-08-01'
      AND stype = 'P'
    GROUP BY
      YearMonth,
      store
    HAVING
      datenum > 19
  ) AS NewTable
GROUP BY
  YearMonth
ORDER BY
  SUM(rev) / sum(datenum) DESC;
```

</details>

Query Result:

|YearMonth             |average_revenue|
|----------------------|---------------|
|       2004         12|34981.66       |
|       2005          2|22745.18       |
|       2005          7|22473.38       |
|       2005          4|21401.67       |
|       2005          3|20633.23       |
|       2005          5|20585.24       |
|       2005          6|20140.48       |
|       2004         11|19404.96       |
|       2004         10|18893.60       |
|       2005          1|18022.09       |
|       2004          9|17611.98       |
|       2004          8|17384.39       |

&nbsp;

## Exercise 10

In what state and zip code is the store that had the greatest total revenue during the time
period monitored in our dataset?

You will need to join two tables to answer this question, and will need to divide your answers up according to
the “state” and “zip” fields. Make sure you include both of these fields in the SELECT and GROUP BY
clauses. Don’t forget to specify that you only want to examine purchase transactions (not returns).

If you have written your query correctly, you will find that the store with the 10th highest total revenue is in
Hurst, TX.

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  (
    CASE
      WHEN m.msa_high > 50
      AND m.msa_high <= 60 THEN 'low'
      WHEN m.msa_high > 60.01
      AND m.msa_high <= 70 THEN 'medium'
      WHEN m.msa_high > 70 THEN 'high'
    END
  ) AS education_level,
  SUM(daily_total_revenue) / SUM(transact.num_days) AS daily_revenue
FROM
  (
    SELECT
      COUNT(DISTINCT saledate) AS num_days,
      (
        EXTRACT(
          MONTH
          FROM
            saledate
        )
      ) AS months,
      (
        EXTRACT(
          YEAR
          FROM
            saledate
        )
      ) AS years,
      store,
      SUM(amt) AS daily_total_revenue,
      (
        CASE
          WHEN EXTRACT(
            MONTH
            FROM
              saledate
          ) = 8
          AND EXTRACT(
            YEAR
            FROM
              saledate
          ) = 2005 THEN 'August 2005'
        END
      ) AS month_years
    FROM
      trnsact
    GROUP BY
      months,
      years,
      store,
      month_years
    WHERE
      stype = 'P'
      AND month_years IS NULL
      AND EXTRACT(
        MONTH
        FROM
          saledate
      ) || EXTRACT(
        YEAR
        FROM
          saledate
      ) || store IN (
        SELECT
          EXTRACT(
            MONTH
            FROM
              saledate
          ) || EXTRACT(
            YEAR
            FROM
              saledate
          ) || store AS month_year_store
        FROM
          trnsact
        GROUP BY
          month_year_store
        HAVING
          COUNT(DISTINCT saledate) >= 20
      )
  ) AS transact
  JOIN store_msa m ON transact.store = m.store
GROUP BY
  education_level
ORDER BY
  daily_revenue DESC,
  education_level;

```

</details>
&nbsp;

Query Result:

|education_level|daily_revenue|
|---------------|-------------|
|low            |34159.76     |
|medium         |25037.89     |
|high           |20937.31     |

&nbsp;
