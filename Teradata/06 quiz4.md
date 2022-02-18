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

## The store_msa table provides population statistics about the geographic location around a store. Using one query to retrieve your answer, how many MSAs are there within the state of North Carolina (abbreviated “NC”), and within these MSAs, what is the lowest population level (msa_pop) and highest income level (msa_income)?

Query:

```SQL
SELECT store, msa_pop, msa_income
FROM store_msa
WHERE state='NC'
ORDER BY msa_pop ASC, msa_income DESC;
```

`16 MSAs, lowest population of 339,511, highest income level of $36,151`

## What department (with department description), brand, style, and color brought in the greatest total amount of sales?

Query:

```SQL
SELECT TOP 5 d.dept, d.deptdesc, SUM(t.amt) as total_amount, s.brand, s.style, s.color
FROM trnsact t INNER JOIN skuinfo s ON t.sku=s.sku
INNER JOIN deptinfo d ON s.dept=d.dept
WHERE stype='P'
GROUP BY d.dept, d.deptdesc, s.brand, s.style, s.color
ORDER BY total_amount DESC
```

`Department 800 described as Clinique, brand Clinique, style 6142, color DDML`

## How many stores have more than 180,000 distinct skus associated with them in the skstinfo table?

Query:

```SQL
SELECT DISTINCT sm.store as store, COUNT(DISTINCT s.sku)
FROM store_msa sm INNER JOIN skstinfo s ON sm.store=s.store
HAVING COUNT(DISTINCT s.sku) > 180000
GROUP BY sm.store
```

`12`

## Look at the data from all the distinct skus in the “cop” department with a “federal” brand and a “rinse wash” color. You'll see that these skus have the same values in some of the columns, meaning that they have some features in common.

In which columns do these skus have different values from one another, meaning that their features differ in the categories represented by the columns? Choose all that apply. Note that you will need more than a single correct selection to answer the question correctly.
Query:

```SQL
SELECT DISTINCT s.sku, d.dept, d.deptdesc, s.brand, s.color, s.style, s.size, s.vendor, s.packsize
FROM skuinfo s INNER JOIN deptinfo d ON s.dept=d.dept
WHERE deptdesc='cop' AND brand='federal' AND color='rinse wash'
```

`style, size`

## How many skus are in the skuinfo table, but NOT in the skstinfo table?

Query:

```SQL
SELECT COUNT(DISTINCT sku)
FROM skuinfo;

SELECT COUNT(DISTINCT sku)
FROM skstinfo;
```

`803,966`

## In what city and state is the store that had the greatest total sum of sales?

Query:

```SQL
SELECT SUM(t.amt) as total_amount, t.store, s.city, s.state
FROM trnsact t JOIN store_msa s ON t.store=s.store
WHERE stype='P'
GROUP BY t.store, s.city, s.state
ORDER BY total_amount DESC
```

`Metairie, LA`

## Given Table A (first table to be entered in the query) and Table B (second table to be entered in the query) the query result shown below is a result of what kind of join?

`Left Join`

## How many states have more than 10 Dillards stores in them?

Query:

```SQL
SELECT DISTINCT state, COUNT(DISTINCT store) as stores
FROM strinfo
HAVING COUNT(DISTINCT store) > 10
GROUP BY state
ORDER BY stores DESC;
```

`15`

## What is the suggested retail price of all the skus in the “reebok” department with the “skechers” brand and a “wht/saphire” color?

Query:

```SQL
SELECT d.deptdesc, s.brand, s.color, t.sprice
FROM trnsact t INNER JOIN skuinfo s ON t.sku=s.sku
INNER JOIN deptinfo d ON s.dept=d.dept
WHERE d.deptdesc='reebok' AND s.brand='skechers' AND s.color='wht/saphire'
```

`$29.00`
