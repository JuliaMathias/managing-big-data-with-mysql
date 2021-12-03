# Week 3 Exercises

## Exercise 1

### A

Use **COUNT** and **DISTINCT** to determine how many distinct skus there are in pairs of the
_skuinfo_, _skstinfo_, and _trnsact_ tables. Which skus are common to pairs of tables, or unique to specific
tables?

The significance of your answers will become clear in Exercise 3.

You will only be tested on queries that compare 2 skus in 2 of the tables listed above at a time. However, if you want to try writing queries that compare all 3 tables at once, you might find the following references helpful:
http://www.w3resource.com/sql/joins/perform-a-left-join.php
http://www.wellho.net/solutions/mysql-left-joins-to-link-three-or-more-tables.html

After interpreting the set of queries you decide to implement, you should conclude that only one of the three tables has distinct skus that are not contained in either of the other tables. However, none of the three tables contain the exact same number of distinct skus.

Note that any queries that join on the trnsact table will likely take a while to run.

<details>
  <summary>single queries</summary>

&nbsp;

```
SELECT COUNT(DISTINCT sku)
FROM skuinfo;
```

Query Result: 1564178

&nbsp;

```
SELECT COUNT(DISTINCT sku)
FROM skstinfo;
```

Query Result: 760212

&nbsp;

```
SELECT COUNT(DISTINCT sku)
FROM trnsact;
```

Query Result: 714499

&nbsp;

</details>

<details>
  <summary>pair queries</summary>

&nbsp;

```
SELECT COUNT(DISTINCT u.sku)
FROM skuinfo u, skstinfo s
WHERE u.sku=s.sku;
```

Query Result: 760212

&nbsp;

```
SELECT COUNT(DISTINCT u.sku)
FROM skuinfo u, trnsact t
WHERE u.sku=t.sku;
```

Query Result: 714499

&nbsp;

```
SELECT COUNT(DISTINCT s.sku)
FROM skstinfo s, trnsact t
WHERE s.sku=t.sku;
```

Query Result: 542513

</details>

&nbsp;

### B

Use **COUNT** to determine how many instances there are of each sku associated with each store in the
_skstinfo_ table and the _trnsact_ table?

Note that these queries will take a while to run.

You should see there are multiple instances of every sku/store combination in the _trnsact_ table, but only one instance of every sku/store combination in the _skstinfo_ table. Therefore you could join the _trnsact_ and _skstinfo_
tables, but you would need to join them on both of the following conditions: **_trnsact.sku= skstinfo.sku AND
trnsact.store= skstinfo.store_**.

```
SELECT sku, store, COUNT(*)
FROM skstinfo
GROUP BY sku, store
ORDER BY COUNT(*) DESC;
```

Query Result: The count is always 1

&nbsp;

```
SELECT COUNT(DISTINCT u.sku)
FROM skuinfo u, trnsact t
WHERE u.sku=t.sku;
```

Query Result:

| Sku     | Store | Count |
| ------- | ----- | ----- |
| 4628597 | 504   | 7933  |
| 5268597 | 2409  | 7607  |
| 4628597 | 8402  | 6884  |
| 8120750 | 9103  | 6570  |
| 4628597 | 2707  | 6534  |

&nbsp;

## Exercise 2

### A

Use **COUNT** and **DISTINCT** to determine how many distinct stores there are in the
_strinfo_, _store_msa_, _skstinfo_, and _trnsact_ tables.

You should see that:

distinct stores in strinfo > distinct stores in skstinfo > distinct stores in store_msa > distinct stores in trnsact

Use this information to help you assess which table to query when answering questions about Dillard’s stores in
the quiz.

&nbsp;

```
SELECT COUNT(DISTINCT store)
FROM strinfo
```

Query Result: 453

&nbsp;

```
SELECT COUNT(DISTINCT store)
FROM skstinfo
```

Query Result: 357

&nbsp;

```
SELECT COUNT(DISTINCT store)
FROM store_msa
```

Query Result: 333

&nbsp;

```
SELECT COUNT(DISTINCT store)
FROM trnsact
```

Query Result: 332

&nbsp;

### B

Which stores are common to all four tables, or unique to specific tables?

Refer to the links provided in Exercise 1a to practice writing queries that compare all 4 tables at once

```
SELECT strinfo.store
FROM strinfo INNER JOIN skstinfo ON strinfo.store = skstinfo.store
INNER JOIN store_msa ON skstinfo.store = store_msa.store
INNER JOIN trnsact ON store_msa.store = trnsact.store;

SELECT DISTINCT strinfo.store, skstinfo.store, store_msa.store, trnsact.store
FROM ((strinfo LEFT JOIN skstinfo ON strinfo.store = skstinfo.store)
LEFT JOIN store_msa ON skstinfo.store = store_msa.store)
LEFT JOIN trnsact ON store_msa.store = trnsact.store


```

Query Result:

&nbsp;

## Exercise 3

It turns out **there are many skus in the _trnsact_ table that are not in the _skstinfo_ table**. As a consequence, we will not be able to complete many desirable analyses of Dillard’s profit, as opposed to revenue, because we do not have the cost information for all the skus in the _transact_ table (recall that profit = revenue - cost). Examine some of the rows in the _trnsact_ table that are not in the _skstinfo_ table; can you find any common features that could explain why the cost information is missing?

Please note: The join you will need to complete this analysis will take a long time to run. This query will give you a good feeling for what working with enterprise-sized data feels like. You might want to pin the results once you retrieve them so that you can examine the results later in the session.

&nbsp;

```
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

&nbsp;

```
SELECT quantity, sprice, amt
WHERE sprice <> amt
FROM TRNSACT;
```

The amt is = quantity \* sprice

&nbsp;

## Exercise 5

Even though the Dillard’s dataset had primary keys declared and there were
not many NULL values, there are still many bizarre entries that likely reflect entry errors.
To see some examples of these likely errors, examine:

- (a) rows in the trsnact table that have “0” in their orgprice column (how could the original
  price be 0?),

```
SELECT *
WHERE orgprice = 0
FROM TRNSACT;
```

- (b) rows in the skstinfo table where both the cost and retail price are listed as 0.00, and

```
SELECT *
WHERE cost = 0.00 AND retail = 0.00
FROM skstinfo;
```

- (c) rows in the skstinfo table where the cost is greater than the retail price (although occasionally retailers will sell an item at a loss for strategic reasons, it is very unlikely that a manufacturer would provide a suggested retail price that is lower than the cost of the item).

```

```

```

```

```

```

```

```

```

```

```

```
