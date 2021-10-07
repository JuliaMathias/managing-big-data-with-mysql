# Week 2 Exercises

## Exercise 1

Use **HELP** and **SHOW** to confirm the relational schema provided to us for the
Dillard’s dataset shows the correct column names and primary keys for each table.

```
HELP table STRINFO;
SHOW table STRINFO;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.STRINFO ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  STORE INTEGER NOT NULL,
  CITY CHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC,
  STATE CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
  ZIP CHAR(5) CHARACTER SET LATIN NOT CASESPECIFIC,
  PRIMARY KEY ( STORE ))
;
```

</details>

&nbsp;

```
HELP table SKSTINFO;
SHOW table SKSTINFO;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.SKSTINFO ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  SKU INTEGER NOT NULL,
  STORE INTEGER NOT NULL,
  COST DECIMAL(7,2),
  RETAIL DECIMAL(7,2),
  PRIMARY KEY ( SKU ,STORE ))
;
```

</details>

&nbsp;

```
HELP table SKUINFO;
SHOW table SKUINFO;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.SKUINFO ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  SKU INTEGER NOT NULL,
  DEPT INTEGER NOT NULL,
  CLASSID CHAR(3) CHARACTER SET LATIN NOT CASESPECIFIC,
  UPC CHAR(15) CHARACTER SET LATIN NOT CASESPECIFIC,
  STYLE CHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC,
  COLOR CHAR(12) CHARACTER SET LATIN NOT CASESPECIFIC,
  SIZE CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
  PACKSIZE INTEGER,
  VENDOR CHAR(7) CHARACTER SET LATIN NOT CASESPECIFIC,
  BRAND CHAR(9) CHARACTER SET LATIN NOT CASESPECIFIC,
  PRIMARY KEY ( SKU ))
;
```

</details>

&nbsp;

```
HELP table STORE_MSA;
SHOW table STORE_MSA;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.STORE_MSA ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  STORE INTEGER NOT NULL,
  CITY CHAR(20) CHARACTER SET LATIN NOT CASESPECIFIC,
  STATE CHAR(2) CHARACTER SET LATIN NOT CASESPECIFIC,
  ZIP CHAR(5) CHARACTER SET LATIN NOT CASESPECIFIC,
  MSA INTEGER,
  MSA_NAME CHAR(40) CHARACTER SET LATIN NOT CASESPECIFIC,
  MSA_POP INTEGER,
  CENSUS_REGION CHAR(30) CHARACTER SET LATIN NOT CASESPECIFIC,
  LATITUDE FLOAT,
  LONGITUDE FLOAT,
  MSA_INCOME INTEGER,
  MSA_HIGH DECIMAL(3,1),
  MSA_BACH DECIMAL(3,1))
PRIMARY INDEX ( STORE );
```

</details>

&nbsp;

```
HELP table TRNSACT;
SHOW table TRNSACT;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.TRNSACT ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  SKU INTEGER NOT NULL,
  STORE INTEGER NOT NULL,
  REGISTER INTEGER NOT NULL,
  TRANNUM CHAR(5) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
  INTERID CHAR(9) CHARACTER SET LATIN NOT CASESPECIFIC,
  SALEDATE DATE FORMAT 'YYYY-MM-DD' NOT NULL,
  STYPE CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC,
  QUANTITY INTEGER,
  ORGPRICE DECIMAL(6,2),
  SPRICE DECIMAL(6,2),
  AMT DECIMAL(7,2),
  SEQ CHAR(9) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
  MIC CHAR(15) CHARACTER SET LATIN NOT CASESPECIFIC,
  PRIMARY KEY ( SKU ,STORE ,REGISTER ,TRANNUM ,SALEDATE ,SEQ ))
;
```

</details>

&nbsp;

```
HELP table DEPTINFO;
SHOW table DEPTINFO;
```

<details>
  <summary>SQL Result</summary>

```
CREATE SET TABLE UA_DILLARDS.DEPTINFO ,FALLBACK ,
   NO BEFORE JOURNAL,
   NO AFTER JOURNAL,
   CHECKSUM = DEFAULT,
   DEFAULT MERGEBLOCKRATIO,
   MAP = TD_MAP1
   (
  DEPT INTEGER NOT NULL,
  DEPTDESC CHAR(8) CHARACTER SET LATIN NOT CASESPECIFIC,
  PRIMARY KEY ( DEPT ))
;
```

</details>

&nbsp;

## Exercise 2

Look at examples of data from each of the tables. Pay particular attention to
the skuinfo table.
Some things to note:

- There are two types of transactions: purchases and returns. We will need to make sure
  we specify which type we are interested in when running queries using the transaction
  table.
- There are a lot of strange values in the “color”, “style”, and “size” fields of the skuinfo
  table. The information recorded in these columns is not always related to the column title
  (for example there are entries like "BMK/TOUR K” and “ALOE COMBO” in the color
  field, even though those entries do not represent colors).
- The department descriptions seem to represent brand names. However, if you look at
  entries in the skuinfo table from only one department, you will see that many brands are
  in the same department.

&nbsp;

```
SELECT *
FROM STRINFO
SAMPLE .05;
SELECT *
FROM SKSTINFO
SAMPLE .05;
SELECT *
FROM skuinfo
SAMPLE .05;
SELECT *
FROM STORE_MSA
SAMPLE .05;
SELECT *
FROM TRNSACT
SAMPLE .05;SELECT *
FROM DEPTINFO
SAMPLE .05;
```

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
- (b) rows in the skstinfo table where both the cost and retail price are listed as 0.00, and
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

```

```
