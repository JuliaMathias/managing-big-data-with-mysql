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
WHERE
  t.stype = 'P'
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
|2762683|HART SCH          |339.8627358490566 |175.8145409584879 |106         |
|5453849|POLO FAS          |279.5532394366197 |169.4139878728892 |284         |
|5623849|POLO FAS          |248.06860962566844|164.40402078315904|187         |
|6039654|HART SCH          |386.53967213114754|154.8453152112351 |122         |
|4213926|POLO FAS          |243.70218045112782|154.57502079915145|133         |

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

Which department, in which city and state of what store, had the greatest % increase in average daily sales revenue from November to December?

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  TOP 1 change_by_store.store,
  change_by_store.dept,
  change_by_store.deptdesc,
  change_by_store.percent_change,
  s.city,
  s.state
FROM
  (
    SELECT
      november.store,
      november.dept,
      november.deptdesc,
      (
        (
          (
            december.daily_average_dec - november.daily_average_nov
          ) / november.daily_average_nov
        ) * 100
      ) AS percent_change
    FROM
      (
        SELECT
          t.store,
          d.dept,
          d.deptdesc,
          (SUM(t.amt) / COUNT(DISTINCT t.saledate)) AS daily_average_nov
        FROM
          trnsact t
          INNER JOIN skuinfo s ON t.sku = s.sku
          INNER JOIN deptinfo d ON s.dept = d.dept
        WHERE
          t.stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                t.saledate
            ) = 11
          )
        GROUP BY
          t.store,
          d.dept,
          d.deptdesc
      ) AS november
      INNER JOIN (
        SELECT
          t.store,
          d.dept,
          d.deptdesc,
          (SUM(t.amt) / COUNT(DISTINCT t.saledate)) AS daily_average_dec
        FROM
          trnsact t
          INNER JOIN skuinfo s ON t.sku = s.sku
          INNER JOIN deptinfo d ON s.dept = d.dept
        WHERE
          t.stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                t.saledate
            ) = 12
          )
        GROUP BY
          t.store,
          d.dept,
          d.deptdesc
      ) AS december ON november.store = december.store
  ) AS change_by_store
  INNER JOIN strinfo s ON change_by_store.store = s.store
ORDER BY
  change_by_store.percent_change DESC;

```

</details>
&nbsp;

Query Result:

|STORE|DEPT|DEPTDESC        |percent_change|CITY                                    |STATE|
|-----|----|----------------|--------------|----------------------------------------|-----|
|9304 |8104|COP KEY         |919335.00     |OKLAHOMA CITY                           |OK   |

&nbsp;

## Exercise 11

What is the city and state of the store that had the greatest decrease in average daily revenue from August to September?

<details>
  <summary>query</summary>

&nbsp;

```SQL
SELECT
  TOP 1 change_by_store.store,
  change_by_store.percent_change,
  s.city,
  s.state
FROM
  (
    SELECT
      august.store,
      (
        (
          (
            september.daily_average_sep - august.daily_average_aug
          ) / august.daily_average_aug
        ) * 100
      ) AS percent_change
    FROM
      (
        SELECT
          store,
          (SUM(amt) / COUNT(DISTINCT saledate)) AS daily_average_aug
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) = 08
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) = 2004
          )
        GROUP BY
          store
      ) AS august
      INNER JOIN (
        SELECT
          store,
          (SUM(amt) / COUNT(DISTINCT saledate)) AS daily_average_sep
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) = 09
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) = 2004
          )
        GROUP BY
          store
      ) AS september ON august.store = september.store
  ) AS change_by_store
  INNER JOIN strinfo s ON change_by_store.store = s.store
ORDER BY
  change_by_store.percent_change;

```

</details>
&nbsp;

Query Result:

|STORE|percent_change|CITY                                    |STATE|
|-----|--------------|----------------------------------------|-----|
|4402 |-75.00        |VERO BEACH                              |FL   |

&nbsp;

## Exercise 12

Determine the month of minimum total revenue for each store. Count the number of stores whose month of minimum total revenue was in each of the twelve months. Then determine the month of minimum average daily revenue. Count the number of stores whose month of minimum average daily revenue was in each of the twelve months. How do they compare?

<details>
  <summary>month of minimum total revenue for each store</summary>

&nbsp;

```SQL
SELECT
  monthly_revenue.store,
  monthly_revenue.dayCount,
  monthly_revenue.mon,
  monthly_revenue.yr,
  minimum_revenue.revenue
FROM
  (
    SELECT
      monthly_revenue.store,
      min(monthly_revenue.revenue) AS revenue
    FROM
      (
        SELECT
          store,
          count(DISTINCT saledate) AS dayCount,
          EXTRACT(
            MONTH
            FROM
              saledate
          ) AS mon,
          EXTRACT(
            YEAR
            FROM
              saledate
          ) AS yr,
          SUM(amt) AS revenue
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) <> 08
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) <> 2005
          )
        HAVING
          dayCount >= 20
        GROUP BY
          store,
          mon,
          yr
      ) AS monthly_revenue
    GROUP BY
      monthly_revenue.store
  ) AS minimum_revenue
  INNER JOIN (
    SELECT
      store,
      count(DISTINCT saledate) AS dayCount,
      EXTRACT(
        MONTH
        FROM
          saledate
      ) AS mon,
      EXTRACT(
        YEAR
        FROM
          saledate
      ) AS yr,
      SUM(amt) AS revenue
    FROM
      trnsact
    WHERE
      stype = 'P'
      AND (
        EXTRACT(
          MONTH
          FROM
            saledate
        ) <> 08
        AND EXTRACT(
          YEAR
          FROM
            saledate
        ) <> 2005
      )
    HAVING
      dayCount >= 20
    GROUP BY
      store,
      mon,
      yr
  ) AS monthly_revenue ON minimum_revenue.revenue = monthly_revenue.revenue
  AND minimum_revenue.store = monthly_revenue.store

```

</details>
&nbsp;

<details>
  <summary>Count the number of stores whose month of minimum total revenue was in each of the twelve months</summary>

&nbsp;

```SQL
SELECT
  min_month.mon,
  count(min_month.store) AS num_stores
FROM
  (
    SELECT
      monthly_revenue.store,
      monthly_revenue.dayCount,
      monthly_revenue.mon,
      monthly_revenue.yr,
      minimum_revenue.revenue
    FROM
      (
        SELECT
          monthly_revenue.store,
          min(monthly_revenue.revenue) AS revenue
        FROM
          (
            SELECT
              store,
              count(DISTINCT saledate) AS dayCount,
              EXTRACT(
                MONTH
                FROM
                  saledate
              ) AS mon,
              EXTRACT(
                YEAR
                FROM
                  saledate
              ) AS yr,
              SUM(amt) AS revenue
            FROM
              trnsact
            WHERE
              stype = 'P'
              AND (
                EXTRACT(
                  MONTH
                  FROM
                    saledate
                ) <> 08
                AND EXTRACT(
                  YEAR
                  FROM
                    saledate
                ) <> 2005
              )
            HAVING
              dayCount >= 20
            GROUP BY
              store,
              mon,
              yr
          ) AS monthly_revenue
        GROUP BY
          monthly_revenue.store
      ) AS minimum_revenue
      INNER JOIN (
        SELECT
          store,
          count(DISTINCT saledate) AS dayCount,
          EXTRACT(
            MONTH
            FROM
              saledate
          ) AS mon,
          EXTRACT(
            YEAR
            FROM
              saledate
          ) AS yr,
          SUM(amt) AS revenue
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) <> 08
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) <> 2005
          )
        HAVING
          dayCount >= 20
        GROUP BY
          store,
          mon,
          yr
      ) AS monthly_revenue ON minimum_revenue.revenue = monthly_revenue.revenue
      AND minimum_revenue.store = monthly_revenue.store
  ) AS min_month
GROUP BY
  min_month.mon

```

</details>
&nbsp;

Query Result:

|mon|num_stores|
|---|----------|
|9  |201       |
|11 |95        |
|10 |28        |
|12 |1         |

&nbsp;

<details>
  <summary>Then determine the month of minimum average daily revenue.</summary>

&nbsp;

```SQL
SELECT
  monthly_revenue.store,
  monthly_revenue.dayCount,
  monthly_revenue.mon,
  monthly_revenue.yr,
  minimum_revenue.daily_average_revenue
FROM
  (
    SELECT
      monthly_revenue.store,
      min(monthly_revenue.daily_average_revenue) AS daily_average_revenue
    FROM
      (
        SELECT
          store,
          count(DISTINCT saledate) AS dayCount,
          EXTRACT(
            MONTH
            FROM
              saledate
          ) AS mon,
          EXTRACT(
            YEAR
            FROM
              saledate
          ) AS yr,
          (SUM(amt) / count(DISTINCT saledate)) AS daily_average_revenue
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) <> 08
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) <> 2005
          )
        HAVING
          dayCount >= 20
        GROUP BY
          store,
          mon,
          yr
      ) AS monthly_revenue
    GROUP BY
      monthly_revenue.store
  ) AS minimum_revenue
  INNER JOIN (
    SELECT
      store,
      count(DISTINCT saledate) AS dayCount,
      EXTRACT(
        MONTH
        FROM
          saledate
      ) AS mon,
      EXTRACT(
        YEAR
        FROM
          saledate
      ) AS yr,
      (SUM(amt) / count(DISTINCT saledate)) AS daily_average_revenue
    FROM
      trnsact
    WHERE
      stype = 'P'
      AND (
        EXTRACT(
          MONTH
          FROM
            saledate
        ) <> 08
        AND EXTRACT(
          YEAR
          FROM
            saledate
        ) <> 2005
      )
    HAVING
      dayCount >= 20
    GROUP BY
      store,
      mon,
      yr
  ) AS monthly_revenue ON minimum_revenue.daily_average_revenue = monthly_revenue.daily_average_revenue
  AND minimum_revenue.store = monthly_revenue.store

```

</details>
&nbsp;

details>
  <summary>Count the number of stores whose month of minimum average daily revenue was in each of the twelve months</summary>

&nbsp;

```SQL
SELECT
  min_month.mon,
  count(min_month.store) AS num_stores
FROM
  (
    SELECT
      monthly_revenue.store,
      monthly_revenue.dayCount,
      monthly_revenue.mon,
      monthly_revenue.yr,
      minimum_revenue.revenue
    FROM
      (
        SELECT
          monthly_revenue.store,
          min(monthly_revenue.revenue) AS revenue
        FROM
          (
            SELECT
              store,
              count(DISTINCT saledate) AS dayCount,
              EXTRACT(
                MONTH
                FROM
                  saledate
              ) AS mon,
              EXTRACT(
                YEAR
                FROM
                  saledate
              ) AS yr,
              SUM(amt) AS revenue
            FROM
              trnsact
            WHERE
              stype = 'P'
              AND (
                EXTRACT(
                  MONTH
                  FROM
                    saledate
                ) <> 08
                AND EXTRACT(
                  YEAR
                  FROM
                    saledate
                ) <> 2005
              )
            HAVING
              dayCount >= 20
            GROUP BY
              store,
              mon,
              yr
          ) AS monthly_revenue
        GROUP BY
          monthly_revenue.store
      ) AS minimum_revenue
      INNER JOIN (
        SELECT
          store,
          count(DISTINCT saledate) AS dayCount,
          EXTRACT(
            MONTH
            FROM
              saledate
          ) AS mon,
          EXTRACT(
            YEAR
            FROM
              saledate
          ) AS yr,
          SUM(amt) AS revenue
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) <> 08
            AND EXTRACT(
              YEAR
              FROM
                saledate
            ) <> 2005
          )
        HAVING
          dayCount >= 20
        GROUP BY
          store,
          mon,
          yr
      ) AS monthly_revenue ON minimum_revenue.revenue = monthly_revenue.revenue
      AND minimum_revenue.store = monthly_revenue.store
  ) AS min_month
GROUP BY
  min_month.mon

```

</details>
&nbsp;

Query Result:

|mon|num_stores|
|---|----------|
|9  |212       |
|10 |58        |
|11 |54        |
|12 |1         |

&nbsp;
