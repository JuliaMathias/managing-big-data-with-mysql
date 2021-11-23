# Quiz 2

**Which of the following keywords are required in any query to retrieve data from a relational database?**

FROM

**Which of the following database systems recognize the keyword “LIMIT” to limit the number of rows displayed from a query output?**

MySQL

**Which keywords could you use to determine the names of the columns contained in a table?**

DESCRIBE in MySQL and HELP in Teradata

**In how many columns of the STRINFO table of the Dillard’s database are NULL values _permitted_?**

```sql
HELP table STRINFO;
SHOW table STRINFO
```

1

**In how many columns of the STRINFO table of the Dillard’s database are NULL values _present_?**

```sql
SELECT *
WHERE city IS NULL or
FROM STRINFO
```

0

**What was the highest original price in the Dillard’s database of the item with SKU 3631365?**

```sql
SELECT *
WHERE sku = 3631365
FROM TRNSACT
ORDER BY orgprice DESC

```

17,50

**What is the color of the Liz Claiborne brand item with the highest SKU # in the Dillard’s database (the Liz Claiborne brand is abbreviated “LIZ CLAI” in the Dillard’s database)?**

```sql
SELECT *
WHERE brand = 'LIZ CLAI'
FROM skuinfo
ORDER BY sku DESC
```

TEAK CBO

**What aspect of the following query will make the query crash?**

SELECT SKU, orgprice, sprice, amt,
FROM TRNSACT
WHERE AMT>50

There is a comma after "amt" in the first line of the query

**What is the sku number of the item in the Dillard’s database that had the highest original sales price?**

```sql
SELECT TOP 10 *
FROM TRNSACT
ORDER BY orgprice DESC
```

6200173

**According to the strinfo table, in how many states within the United States are Dillard’s stores located? (HINT: the bottom of the SQL scratchpad reports the number of rows in your output)**

```sql
SELECT DISTINCT state
FROM STRINFO
```

31

**How many Dillard’s departments start with the letter “e”**

```sql
SELECT * FROM DEPTINFO
WHERE DEPTDESC LIKE 'E%'

```

5

**What was the date of the earliest sale in the database where the sale price of the item did not equal the original price of the item, and what was the largest margin (original price minus sale price) of an item sold on that earliest date?**

```sql
SELECT orgprice, sprice, saledate
WHERE orgprice <> sprice
FROM TRNSACT
ORDER BY saledate

```

04/08/01, $510.00

**What register number recorded the transaction with the highest original price and highest sale price between the dates of August 1, 2004 and August 10, 2004? Make sure to sort by original price first and sale price second.**

```sql
SELECT register,orgprice, sprice, saledate
WHERE saledate BETWEEN '2004-08-01' AND '2004-08-10'
FROM TRNSACT
ORDER BY orgprice DESC, sprice DESC
```

621

**Which of the following brand names with the word/letters “liz” in them exist in the Dillard’s database? Select all that apply. Note that you will need more than a single correct selection to answer the question correctly.**

```sql
SELECT *
WHERE brand = 'REVITALIZE' or brand = 'BELIZA' or brand = 'CIVILIZE' or brand = 'LIZ MOOR'
FROM SKUINFO
```

BELIZA, CIVILIZE

**What is the lowest store number of all the stores in the STORE_MSA table that are in the city of “little rock”,”memphis”, or “tulsa”?**

```sql
SELECT store, city
WHERE city = 'little rock' or city = 'memphis' or city = 'tulsa'
FROM store_msa
ORDER BY store

```

504
