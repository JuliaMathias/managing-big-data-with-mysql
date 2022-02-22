# Quiz 3

## How many distinct skus have the brand “Polo fas”, and are either size “XXL” or “black” in color?

Query:

```SQL
SELECT
  count(DISTINCT sku)
FROM
  skuinfo
WHERE
  brand = 'Polo fas'
  AND (
    size = 'XXL '
    OR color = 'black'
  )
```

`13623`

## There was one store in the database which had only 11 days in one of its months (in other words, that store/month/year combination only contained 11 days of transaction data).  In what city and state was this store located?

Query:

```SQL
SELECT
  t.store,
  count(DISTINCT t.saledate) AS dayCount,
  EXTRACT(
    MONTH
    FROM
      t.saledate
  ) AS mon,
  EXTRACT(
    YEAR
    FROM
      t.saledate
  ) AS yr,
  s.city,
  s.state
FROM
  trnsact t
  INNER JOIN strinfo s ON t.store = s.store
WHERE
  t.stype = 'P'
HAVING
  dayCount = 11
GROUP BY
  t.store,
  mon,
  yr,
  s.city,
  s.state
```

`Atlanta, GA`

## Which sku number had the greatest increase in total sales revenue from November to December?

Query:

```SQL
SELECT
  change_by_sku.sku,
  change_by_sku.revenue_nov,
  change_by_sku.revenue_dec,
  change_by_sku.percent_change
FROM
  (
    SELECT
      november.sku,
      november.revenue_nov,
      december.revenue_dec,
      (
        (
          (
            december.revenue_dec - november.revenue_nov
          ) / november.revenue_nov
        ) * 100
      ) AS percent_change
    FROM
      (
        SELECT
          t.sku,
          SUM(t.amt) AS revenue_nov
        FROM
          trnsact t
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
          t.sku
      ) AS november
      INNER JOIN (
        SELECT
          t.sku,
          SUM(t.amt) AS revenue_dec
        FROM
          trnsact t
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
          t.sku
      ) AS december ON november.sku = december.sku
  ) AS change_by_sku
WHERE
  sku = '6966816'
  OR sku = '3949538'
  OR sku = '2637537'
  OR sku = '4737469'
ORDER BY
  change_by_sku.percent_change DESC;
```

`6966816`

## What vendor has the greatest number of distinct skus in the transaction table that do not exist in the skstinfo table?  (Remember that vendors are listed as distinct numbers in our data set)

Query:

```SQL
SELECT
  s.vendor,
  count(new_transact.sku) AS sku_num
FROM
  (
    SELECT
      DISTINCT t.sku
    FROM
      trnsact t
      LEFT JOIN skstinfo si ON t.sku = si.sku
    WHERE
      si.sku IS NULL
  ) AS new_transact
  INNER JOIN skuinfo s ON new_transact.sku = s.sku
GROUP BY
  s.vendor
ORDER BY
  sku_num DESC;
```

`5715232`

## What is the brand of the sku with the greatest standard deviation in sprice?  Only examine skus which have been part of over 100 transactions

Query:

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

`Hart Sch`

## What is the city and state of the store which had the greatest increase in average daily revenue (as defined in Teradata Week 5 Exercise Guide) from November to December?

```SQL
SELECT
  TOP 5 change_by_store.store,
  change_by_store.daily_average_nov,
  change_by_store.daily_average_dec,
  change_by_store.increase,
  s.city,
  s.state
FROM
  (
    SELECT
      november.store,
      november.daily_average_nov,
      december.daily_average_dec,
      (
        december.daily_average_dec - november.daily_average_nov
      ) AS increase
    FROM
      (
        SELECT
          store,
          (SUM(amt) / COUNT(DISTINCT saledate)) AS daily_average_nov
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) = 11
          )
        HAVING
          COUNT(DISTINCT saledate) >= 20
        GROUP BY
          store
      ) AS november
      INNER JOIN (
        SELECT
          store,
          (SUM(amt) / COUNT(DISTINCT saledate)) AS daily_average_dec
        FROM
          trnsact
        WHERE
          stype = 'P'
          AND (
            EXTRACT(
              MONTH
              FROM
                saledate
            ) = 12
          )
        HAVING
          COUNT(DISTINCT saledate) >= 20
        GROUP BY
          store
      ) AS december ON november.store = december.store
  ) AS change_by_store
  INNER JOIN strinfo s ON change_by_store.store = s.store
ORDER BY
  change_by_store.increase DESC;
```

`Metairie, LA`

## Compare the average daily revenue (as defined in Teradata Week 5 Exercise Guide) of the store with the highest msa_income and the store with the lowest median msa_income (according to the msa_income field).  In what city and state were these two stores, and which store had a higher average daily revenue?

Query:

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

`The store with the highest median msa_income was in Spanish Fort, AL.  It had a lower average daily revenue than the store with the lowest median msa_income, which was in McAllen, TX.`

## Divide the msa_income groups up so that msa_incomes between 1 and 20,000 are labeled 'low', msa_incomes between 20,001 and 30,000 are labeled 'med-low', msa_incomes between 30,001 and 40,000 are labeled 'med-high', and msa_incomes between 40,001 and 60,000 are labeled 'high'.  Which of these groups has the highest average daily revenue (as defined in Teradata Week 5 Exercise Guide) per store?

Query:

```SQL
SELECT
  (
    CASE
      WHEN m.msa_income > 1
      AND m.msa_income <= 20000 THEN 'low'
      WHEN m.msa_income > 20001
      AND m.msa_income <= 30000 THEN 'med-low'
      WHEN m.msa_income > 30001
      AND m.msa_income <= 40000 THEN 'med-high'
      WHEN m.msa_income > 40001
      AND m.msa_income <= 60000 THEN 'high'
    END
  ) AS income,
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
  income
ORDER BY
  daily_revenue DESC,
  income;
```

Query result:

|income  |daily_revenue|
|--------|-------------|
|low     |34159.76     |
|med-high|21999.69     |
|med-low |19312.10     |
|high    |18129.42     |

`low`

## Divide stores up so that stores with msa populations between 1 and 100,000 are labeled 'very small', stores with msa populations between 100,001 and 200,000 are labeled 'small', stores with msa populations between 200,001 and 500,000 are labeled 'med_small', stores with msa populations between 500,001 and 1,000,000 are labeled 'med_large', stores with msa populations between 1,000,001 and 5,000,000 are labeled “large”, and stores with msa_population greater than 5,000,000 are labeled “very large”.  What is the average daily revenue (as defined in Teradata Week 5 Exercise Guide) for a store in a “very large” population msa?

Query:

```SQL
SELECT
  (
    CASE
      WHEN m.msa_pop >= 1
      AND m.msa_pop <= 100000 THEN 'very small'
      WHEN m.msa_pop >= 100001
      AND m.msa_pop <= 200000 THEN 'small'
      WHEN m.msa_pop >= 200001
      AND m.msa_pop <= 500000 THEN 'med_small'
      WHEN m.msa_pop >= 500001
      AND m.msa_pop <= 1000000 THEN 'med_large'
      WHEN m.msa_pop >= 1000001
      AND m.msa_pop <= 5000000 THEN 'large'
      WHEN m.msa_pop > 5000000 THEN 'very large'
    END
  ) AS population_size,
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
  population_size
ORDER BY
  daily_revenue DESC,
  population_size;
```

Query result:

|population_size|daily_revenue|
|---------------|-------------|
|very large     |25451.53     |
|med_large      |24341.59     |
|large          |22107.57     |
|med_small      |21208.43     |
|small          |16355.16     |
|very small     |12688.25     |

`$25,452`

## Which department in which store had the greatest percent increase in average daily sales revenue from November to December, and what city and state was that store located in?   Only examine departments whose total sales were at least $1,000 in both November and December

Query:

```SQL
SELECT
  store_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  s.city,
  s.state,
  (
    (
      (
        (dept_info.dec_amt / store_info.dec_days) - (dept_info.nov_amt / store_info.nov_days)
      ) / (dept_info.nov_amt / store_info.nov_days)
    ) * 100
  ) AS percent_change,
  dept_info.nov_amt,
  store_info.nov_days,
  dept_info.dec_amt,
  store_info.dec_days,
  (dept_info.nov_amt / store_info.nov_days) AS daily_average_nov,
  (dept_info.dec_amt / store_info.dec_days) AS daily_average_dec
FROM
  (
    SELECT
      t.store,
      count(
        DISTINCT CASE
          WHEN extract(
            MONTH
            FROM
              t.saledate
          ) = 11 THEN t.saledate
        END
      ) AS nov_days,
      count(
        DISTINCT CASE
          WHEN extract(
            MONTH
            FROM
              t.saledate
          ) = 12 THEN t.saledate
        END
      ) AS dec_days
    FROM
      trnsact t
    WHERE
      t.stype = 'p'
    HAVING
      nov_days >= 20
      AND dec_days >= 20
    GROUP BY
      t.store
  ) AS store_info
  INNER JOIN (
    SELECT
      t.store,
      d.dept,
      d.deptdesc,
      SUM(
        CASE
          WHEN extract(
            MONTH
            FROM
              t.saledate
          ) = 11 THEN t.amt
        END
      ) AS nov_amt,
      SUM(
        CASE
          WHEN extract(
            MONTH
            FROM
              t.saledate
          ) = 12 THEN t.amt
        END
      ) AS dec_amt
    FROM
      trnsact t
      INNER JOIN skuinfo s ON t.sku = s.sku
      INNER JOIN deptinfo d ON s.dept = d.dept
    WHERE
      t.stype = 'p'
    HAVING
      nov_amt >= 1000
      AND dec_amt >= 1000
    GROUP BY
      t.store,
      d.dept,
      d.deptdesc
  ) AS dept_info ON store_info.store = dept_info.store
  INNER JOIN strinfo s ON dept_info.store = s.store
WHERE
  (
    dept_info.deptdesc = 'JACQUES'
    AND s.city = 'JACKSON'
    AND s.state = 'MS'
  )
  OR (
    dept_info.deptdesc = 'CLINIQUE'
    AND s.city = 'ODESSA'
    AND s.state = 'TX'
  )
  OR (
    dept_info.deptdesc = 'LOUISVL'
    AND s.city = 'SALINA'
    AND s.state = 'KS'
  )
  OR (
    dept_info.deptdesc = 'GOTTEX'
    AND s.city = 'PINE BLUFF'
    AND s.state = 'AR'
  )
GROUP BY
  store_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  dept_info.nov_amt,
  store_info.nov_days,
  dept_info.dec_amt,
  store_info.dec_days,
  s.city,
  s.state
ORDER BY
  percent_change DESC;
```

`Louisvl department, Salina, KS`

## Which department within a particular store had the greatest decrease in average daily sales revenue from August to September, and in what city and state was that store located?

Query:

```SQL
SELECT
  store_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  s.city,
  s.state,
  (
    (dept_info.sep_amt / store_info.sep_days) - (dept_info.aug_amt / store_info.aug_days)
  ) AS revenue_change,
  (dept_info.aug_amt / store_info.aug_days) AS daily_average_aug,
  dept_info.aug_amt,
  store_info.aug_days,
  (dept_info.sep_amt / store_info.sep_days) AS daily_average_sep,
  dept_info.sep_amt,
  store_info.sep_days
FROM
  (
    SELECT
      t.store,
      count(
        DISTINCT CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 08
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.saledate
        END
      ) AS aug_days,
      count(
        DISTINCT CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 09
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.saledate
        END
      ) AS sep_days
    FROM
      trnsact t
    WHERE
      t.stype = 'p'
    HAVING
      aug_days >= 20
      AND sep_days >= 20
    GROUP BY
      t.store
  ) AS store_info
  INNER JOIN (
    SELECT
      t.store,
      d.dept,
      d.deptdesc,
      SUM(
        CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 08
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.amt
        END
      ) AS aug_amt,
      SUM(
        CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 09
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.amt
        END
      ) AS sep_amt
    FROM
      trnsact t
      INNER JOIN skuinfo s ON t.sku = s.sku
      INNER JOIN deptinfo d ON s.dept = d.dept
    WHERE
      t.stype = 'p'
    HAVING
      aug_amt >= 1000
      AND sep_amt >= 1000
    GROUP BY
      t.store,
      d.dept,
      d.deptdesc
  ) AS dept_info ON store_info.store = dept_info.store
  INNER JOIN strinfo s ON dept_info.store = s.store
GROUP BY
  store_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  dept_info.aug_amt,
  store_info.aug_days,
  dept_info.sep_amt,
  store_info.sep_days,
  s.city,
  s.state
ORDER BY
  revenue_change DESC;

```

`Clinique department, Louisville, KY`

## Identify which department, in which city and state of what store, had the greatest DECREASE in the number of items sold from August to September.  How many fewer items did that department sell in September compared to August?

Query:

```SQL
SELECT
  TOP 5 dept_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  s.city,
  s.state,
  (dept_info.sep_quantity - dept_info.aug_quantity) AS quantity_change,
  dept_info.aug_quantity,
  dept_info.sep_quantity
FROM
  (
    SELECT
      t.store,
      d.dept,
      d.deptdesc,
      SUM(
        CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 08
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.quantity
        END
      ) AS aug_quantity,
      SUM(
        CASE
          WHEN (
            extract(
              MONTH
              FROM
                t.saledate
            ) = 09
            AND extract(
              YEAR
              FROM
                t.saledate
            ) = 2004
          ) THEN t.quantity
        END
      ) AS sep_quantity
    FROM
      trnsact t
      INNER JOIN skuinfo s ON t.sku = s.sku
      INNER JOIN deptinfo d ON s.dept = d.dept
    WHERE
      t.stype = 'p'
    HAVING
      aug_quantity >= 1
      AND sep_quantity >= 1
    GROUP BY
      t.store,
      d.dept,
      d.deptdesc
  ) AS dept_info
  INNER JOIN strinfo s ON dept_info.store = s.store
GROUP BY
  dept_info.store,
  dept_info.dept,
  dept_info.deptdesc,
  dept_info.aug_quantity,
  dept_info.sep_quantity,
  s.city,
  s.state
ORDER BY
  quantity_change ASC;
```

`The Clinique department in Louisville, KY sold 13,491 fewer items`

## For each store, determine the month with the minimum average daily revenue (as defined in Teradata Week 5 Exercise Guide) .  For each of the twelve months of the year,  count how many stores' minimum average daily revenue was in that month.  During which month(s) did over 100 stores have their minimum average daily revenue?

Query:

```SQL
SELECT
  monthly_data.mon,
  count(monthly_data.store) AS num_stores
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
      (SUM(amt) / count(DISTINCT saledate)) AS avg_daily_revenue,
      (
        ROW_NUMBER() OVER (
          PARTITION BY store
          ORDER BY
            (SUM(amt) / count(DISTINCT saledate)) ASC
        )
      ) AS ranking
    FROM
      trnsact
    WHERE
      stype = 'P'
      AND saledate < '2005-08-01'
    HAVING
      dayCount >= 20
    GROUP BY
      store,
      mon
  ) AS monthly_data
WHERE
  monthly_data.ranking = 1
GROUP BY
  monthly_data.mon
ORDER BY
  num_stores DESC
```

`August only`

## Write a query that determines the month in which each store had its maximum number of sku units returned.  During which month did the greatest number of stores have their maximum number of sku units returned?

Query:

```SQL
SELECT
  monthly_data.mon,
  count(monthly_data.store) AS num_stores
FROM
  (
    SELECT
      store,
      EXTRACT(
        MONTH
        FROM
          saledate
      ) AS mon,
      count(quantity) AS quantity,
      (
        ROW_NUMBER() OVER (
          PARTITION BY store
          ORDER BY
            count(quantity) DESC
        )
      ) AS ranking
    FROM
      trnsact
    WHERE
      stype = 'R'
      AND saledate < '2005-08-01'
    GROUP BY
      store,
      mon
  ) AS monthly_data
WHERE
  monthly_data.ranking = 1
GROUP BY
  monthly_data.mon
ORDER BY
  num_stores DESC
```

`Write a query that determines the month in which each store had its maximum number of sku units returned.  During which month did the greatest number of stores have their maximum number of sku units returned?`
