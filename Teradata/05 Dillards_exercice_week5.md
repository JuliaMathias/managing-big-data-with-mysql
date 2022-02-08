# Week 5 Exercises

## Exercise 1

How many distinct dates are there in the saledate column of the transaction
table for each **month/year** combination in the database?

<details>
  <summary>query</summary>
>>>>>>> Stashed changes

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

To determine the _sku_ that had the greatest combined total sales during the summer months, make one `CASE` statement that sums up all the sales in June, another that sums up all the sales in July, and a third that sums up all the sales in August. Then include another field in your `SELECT` statement that adds those 3 numbers together. Group your output by _sku_, and sort the output by
the derived field that adds the revenue from the 3 months together. Don’t forget to restrict your sales transaction types to purchases.

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

It turns out **there are many skus in the _trnsact_ table that are not in the _skstinfo_ table**. As a consequence, we will not be able to complete many desirable analyses of Dillard’s profit, as opposed to revenue, because we do not have the cost information for all the skus in the _transact_ table (recall that profit = revenue - cost). Examine some of the rows in the _trnsact_ table that are not in the _skstinfo_ table; can you find any common features that could explain why the cost information is missing?

Please note: The join you will need to complete this analysis will take a long time to run. This query will give you a good feeling for what working with enterprise-sized data feels like. You might want to pin the results once you retrieve them so that you can examine the results later in the session.

&nbsp;

```SQL
SELECT *
FROM trnsact
LEFT JOIN skstinfo ON trnsact.sku = skstinfo.sku
WHERE skstinfo.sku IS NULL

```

**Tables:** none

&nbsp;

## Exercise 4

Although we can’t complete all the analyses we’d like to on Dillard’s profit, we can look at general trends. What is Dillard’s average profit per day?

We can justify examining the average profit per day (excluding transactions that cannot be joined with the skstinfo), but we cannot justify examining the total profit over a given timeframe because there are too many
transactions for which we do not have cost information.

To calculate profit, subtract the total cost of the items in a transaction from the total revenue brought in during the transaction. Refer to the Dillard’s Department Store Database Metadata and what you’ve seen so far to determine what column—or columns—represents total revenue, and what columns are needed to calculate the total cost associated with a transaction (note that some transactions have multiple items, so you will need to take that into account in your calculations, especially your cost calculations). If you are interested in looking at the total value of goods purchased or returned, use the “amt” field. If you are interested in looking at the total number of goods purchased or returned, use the “quantity” field. Make sure to specify the correct stype in your query. Pay close attention to what we learned in Exercise 1b.

If you are calculating the average profit per day correctly, you will find that the average profit per day from
register 640 is $10,779.20.

the profit of a single transaction is: amt - (cost \* quantity)

so the average profit of an item would be sum(amt) - sum(cost) \* sum(quantity) / count(days)

&nbsp;

```SQL
SELECT SUM(t.amt) as total_amount,
SUM(t.quantity) as total_quantity,
SUM(si.cost) as total_cost,
COUNT(DISTINCT t.saledate) as number_of_days,
SUM(amt-(si.cost*t.quantity))/ COUNT(DISTINCT t.saledate) AS avg_sales
FROM trnsact t JOIN skstinfo si ON t.sku=si.sku AND t.store=si.store
WHERE stype='P'
```

| total_amount | total_quantity | total_cost   | days | avg_sales  |
| ------------ | -------------- | ------------ | ---- | ---------- |
| 1530055284.6 | 63451484       | 935700838.24 | 389  | 1527903.46 |

&nbsp;

## Exercise 5

On what day was the total value (in $) of returned goods the greatest? On what day was the total number of individual returned items the greatest?

Make sure to specify the correct stype in your query. If you are interested in looking at the total value of goods
purchased or returned, use the `amt` field. If you are interested in looking at the total number of goods purchased or returned, use the `quantity` field.

- (a) total value

```SQL
SELECT DISTINCT t.saledate, SUM(t.amt) as total_amount
FROM trnsact t JOIN skstinfo si ON t.sku=si.sku AND t.store=si.store
WHERE stype='R'
GROUP BY t.saledate
ORDER BY total_amount DESC
```

| total_amount | sale_date |
| ------------ | --------- |
| 1212071.96   | 04/12/27  |
| 1040333.67   | 04/12/26  |
| 980995.01    | 05/07/30  |
| 956986.41    | 05/08/27  |
| 942881.31    | 04/12/28  |

- (b) amount of goods returned

```SQL
SELECT DISTINCT t.saledate, SUM(t.quantity) as total_quantity
FROM trnsact t JOIN skstinfo si ON t.sku=si.sku AND t.store=si.store
WHERE stype='R'
GROUP BY t.saledate
ORDER BY total_quantity DESC
```

| total_quantity | sale_date |
| -------------- | --------- |
| 36984          | 05/07/30  |
| 36481          | 05/08/27  |
| 33723          | 04/12/27  |
| 31558          | 05/07/29  |
| 29657          | 05/02/26  |

## Exercise 6

What is the maximum price paid for an item in our database? What is the minimum price paid for an item in our database?

Make sure to use the correct column to address these questions (use the same column(s) as you used to calculate revenue). The answer to the minimum price question is likely evidence of more incorrect entries.

- (a) maximum price

```SQL
SELECT TOP 5 *
FROM trnsact t JOIN skstinfo si ON t.sku=si.sku AND t.store=si.store
WHERE stype='P'
ORDER BY t.amt DESC

```

| SKU     | STORE | REGISTER | SALEDATE   | STYPE | QUANTITY | ORGPRICE | SPRICE  | AMT     | STORE | COST    | RETAIL  |
| ------- | ----- | -------- | ---------- | ----- | -------- | -------- | ------- | ------- | ----- | ------- | ------- |
| 6200173 | 1607  | 650      | 2005-03-29 | P     | 1        | 6017.00  | 6017.00 | 6017.00 | 1607  | 2700.00 | 6017.00 |
| 3733090 | 1007  | 550      | 2004-12-31 | P     | 1        | 6.00     | 5005.00 | 5005.00 | 1007  | 2.16    | 6.00    |
| 9747774 | 5002  | 400      | 2005-07-01 | P     | 1        | 5.00     | 4004.00 | 4004.00 | 5002  | 1.68    | 5.00    |
| 2139390 | 1607  | 280      | 2005-05-04 | P     | 1        | 1895.00  | 1895.00 | 1895.00 | 1607  | 895.00  | 1895.00 |
| 4930553 | 209   | 231      | 2005-08-20 | P     | 1        | 1600.00  | 1600.00 | 1600.00 | 209   | 960.00  | 1600.00 |

- (b) minimum price

```SQL
SELECT TOP 5 *
FROM trnsact t JOIN skstinfo si ON t.sku=si.sku AND t.store=si.store
WHERE stype='P' AND t.amt <> 0.00
ORDER BY t.amt
```

0.01

## Exercise 7

How many departments have more than 100 brands associated with them, and what are their descriptions?

A **HAVING** clause will be helpful for addressing this question. You will also need a join to combine the
skuinfo and deptinfo tables in order to retrieve the descriptions of the departments.

```SQL
SELECT d.dept, d.deptdesc, COUNT(s.brand) as brands
FROM deptinfo d JOIN skuinfo s ON d.dept=s.dept
HAVING COUNT(s.brand) > 100
GROUP BY d.dept, d.deptdesc
ORDER BY COUNT(s.brand) DESC
```

60 depts

## Exercise 8

Write a query that retrieves the department descriptions of each of the skus in the `skstinfo` table.

You will need to join 3 tables in this query. Start by writing a query that connects the `skstinfo` and `skuinfo`
tables. Once you are sure that query works, connect the `deptinfo` table. You may want to explore what happens
when you incorporate aggregate functions into your query. When you do so, make sure all of your column
names are referenced by the correct table aliases.

If you have written your query correctly, you will find that the department description for sku #5020024 is “LESLIE”.

```SQL
SELECT skstinfo.sku, skstinfo.store, sku.dept, d.deptdesc
FROM skstinfo INNER JOIN skuinfo sku ON skstinfo.sku=sku.sku
INNER JOIN deptinfo d ON sku.dept=d.dept
WHERE sku.sku = 5020024
```

## Exercise 9

What department (with department description), brand, style, and color had the greatest total value of returned items?

You will need to join 3 tables in this query. Start by writing a query that connects 2 tables. Once you are sure
that query works, connect the 3rd table. Make sure you include both of these fields in the SELECT and GROUP
BY clauses. Make sure any non-aggregate column in your SELECT list is also listed in your GROUP BY
clause.

If you have written your query correctly, you will find that the department with the 5th highest total value of
returned items is #2200 with a department description of “CELEBRT”, a brand of “LANCOME”, a style of
“1042”, a color of “00-NONE”, and a total value of returned items of $177,142.50.

```SQL
SELECT TOP 5 d.dept, d.deptdesc, SUM(t.amt) as total_amount, s.brand, s.style, s.color
FROM trnsact t INNER JOIN skuinfo s ON t.sku=s.sku
INNER JOIN deptinfo d ON s.dept=d.dept
WHERE stype='R'
GROUP BY d.dept, d.deptdesc, s.brand, s.style, s.color
ORDER BY total_amount DESC
```

| DEPT | DEPTDESC | total_amount | BRAND    | STYLE        | COLOR      |
| ---- | -------- | ------------ | -------- | ------------ | ---------- |
| 4505 | POLOMEN  | 216633.59    | POLO FAS | 4GZ 782633   | U KHAKI    |
| 7307 | SIGRID O | 202424.05    | NOBLE EX | HMANO ENGLIS | ROSE       |
| 7307 | SIGRID O | 190183.61    | NOBLE EX | CHLOE        | PETAL PINK |
| 7307 | SIGRID O | 187096.67    | NOBLE EX | 3133         | SAND       |
| 2200 | CELEBRT  | 177142.50    | LANCOME  | 1042         | 00-NONE    |

## Exercise 10

In what state and zip code is the store that had the greatest total revenue during the time
period monitored in our dataset?

You will need to join two tables to answer this question, and will need to divide your answers up according to
the “state” and “zip” fields. Make sure you include both of these fields in the SELECT and GROUP BY
clauses. Don’t forget to specify that you only want to examine purchase transactions (not returns).

If you have written your query correctly, you will find that the store with the 10th highest total revenue is in
Hurst, TX.

```SQL
SELECT TOP 10 SUM(t.amt) as total_amount, t.store, s.state, s.city, s.zip
FROM trnsact t JOIN store_msa s ON t.store=s.store
WHERE stype='P'
GROUP BY t.store, s.state, s.city, s.zip
ORDER BY total_amount DESC
```

| total_amount | STORE | STATE | CITY          | ZIP   |
| ------------ | ----- | ----- | ------------- | ----- |
| 24171426.58  | 8402  | LA    | METAIRIE      | 70002 |
| 22792579.65  | 504   | AR    | LITTLE ROCK   | 72205 |
| 22331884.55  | 2707  | TX    | MCALLEN       | 78501 |
| 22063797.73  | 1607  | TX    | DALLAS        | 75225 |
| 20114154.20  | 9103  | KY    | LOUISVILLE    | 40207 |
| 19040376.84  | 7507  | TX    | HOUSTON       | 77056 |
| 18642976.76  | 2203  | KS    | OVERLAND PARK | 66214 |
| 18458644.39  | 9304  | OK    | OKLAHOMA CITY | 73118 |
| 18455775.63  | 2007  | TX    | SAN ANTONIO   | 78216 |
| 17740181.20  | 107   | TX    | HURST         | 76053 |
