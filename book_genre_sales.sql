WITH 
--aggregating first quarter sles
	sq1 AS
		(
			SELECT 
				isbn
				, SUM(sales) as q1sales
			FROM salesq1 
			GROUP BY isbn
		)
,
--aggregating second quarter sales
	sq2 AS 
		(
			SELECT 
				isbn
				, SUM(sales) as q2sales
			FROM salesq2 
			GROUP BY isbn
		)
,
--aggregating third quarter sales
	sq3 AS
		(
			SELECT 
				isbn
				, SUM(sales) as q3sales
			FROM salesq3 
			GROUP BY isbn
		)
,
--aggregating fourth quarter sales
	sq4 AS
		(
			SELECT 
				isbn
				, SUM(sales) as q4sales
			FROM salesq4 
			GROUP BY isbn
		)

SELECT
      e.bookid								AS bookid
      , genre								AS genre
      , b.title								AS title
      , count(distinct a."award name")					AS award_count
      , sum(sq1.q1sales)						AS q1_sales
      , sum(sq2.q2sales)						AS q2_sales
      , sum(sq3.q3sales)						AS q3_sales
      , sum(sq4.q4sales)						AS q4_sales
      , sum(sq1.q1sales) 
      	+ sum(sq2.q2sales) 
		+ sum(sq3.q3sales) 
			+ sum(sq4.q4sales) 				AS total_sales
FROM edition e
LEFT JOIN info i
ON e.bookid = CONCAT(i.bookid1,bookid2)
LEFT JOIN book b
on e.bookid = b.bookid
LEFT JOIN sq1
ON e.isbn = sq1.isbn
LEFT JOIN sq2
ON e.isbn = sq2.isbn
LEFT JOIN sq3
ON e.isbn = sq3.isbn
LEFT JOIN sq4
ON e.isbn = sq4.isbn
JOIN award a
on b.title = a.title
GROUP BY 
	e.bookid
	, genre
	, b.title
