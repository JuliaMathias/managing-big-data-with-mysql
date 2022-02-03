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

SELECT
  DISTINCT (
    extract(
      year
      FROM
        saledate
    ) || extract(
      MONTH
      FROM
        saledate
    )
  ) AS SaleDate,
  COUNT(DISTINCT saledate) AS NumDays
FROM
  trnsact
GROUP BY
  SaleDate
ORDER BY
  SaleDate;