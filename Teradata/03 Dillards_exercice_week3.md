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

| Sku     | Store | Count |
| ------- | ----- | ----- |
| 4628597 | 504   | 7933  |
| 5268597 | 2409  | 7607  |
| 4628597 | 8402  | 6884  |
| 8120750 | 9103  | 6570  |
| 4628597 | 2707  | 6534  |

&nbsp;

## Exercise 3

Examine lists of distinct values in each of the tables. Note which tables have fewer distinct rows that they have total rows

&nbsp;

```
SELECT *
FROM STRINFO;
SELECT DISTINCT *
FROM STRINFO;
SELECT *
FROM SKSTINFO;
SELECT DISTINCT *
FROM SKSTINFO;
SELECT *
FROM skuinfo;
SELECT DISTINCT *
FROM skuinfo;
SELECT *
FROM STORE_MSA;
SELECT DISTINCT *
FROM STORE_MSA;
SELECT *
FROM TRNSACT;
SELECT DISTINCT *
FROM TRNSACT;
SELECT *
FROM DEPTINFO;
SELECT DISTINCT *
FROM DEPTINFO;

```

**Tables:** none

&nbsp;

## Exercise 4

Examine instances of transaction table where “amt” is different than “sprice”. What did you learn about how the values in “amt”, “quantity”, and “sprice” relate to one
another?

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
