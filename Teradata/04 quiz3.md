# Quiz 3

## It is important that you work through the Teradata exercises for before attempting this quiz

Given Table A (first table to be entered in the query) and Table B (second table to be entered in the query) the query result shown below is a result of what kind of join?

`Right Join`

## On what day was Dillard’s income based on total sum of purchases the greatest

Query:

```SQL
SELECT saledate, sum(amt) AS Income
FROM trnsact
WHERE stype='P'
GROUP BY saledate
ORDER BY Income DESC
```

`04/11/01`

## What is the deptdesc of the departments that have the top 3 greatest numbers of skus from the skuinfo table associated with them?

Query:

```SQL
SELECT TOP 5 d.dept, d.deptdesc, COUNT(DISTINCT s.sku) as sku_amount
FROM skuinfo s INNER JOIN deptinfo d ON s.dept=d.dept
GROUP BY d.dept, d.deptdesc
ORDER BY sku_amount DESC
```

`INVEST, POLOMEN, BRIOSO`

## Which table contains the most distinct sku numbers?

`skuinfo`

## How many skus are in the skstinfo table, but NOT in the skuinfo table?

Query:

```SQL
SELECT COUNT(DISTINCT s.sku)
FROM skstinfo s, skuinfo u
WHERE s.sku <> u.sku;
```

`0`

## What is the average amount of profit Dillard’s made per day?

`1,527,903`

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
