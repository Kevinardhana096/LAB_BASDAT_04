SET search_path TO classicmodels, public;

-- soal 1
SELECT 
	ordernumber, 
	UPPER(productcode) AS "Kode Produk", 
	quantityordered, 
	priceeach 
FROM orderdetails

WHERE 
	(quantityordered BETWEEN 20 AND 50 OR priceeach < 30) AND
	LEFT(productcode, 3) = 'S18'
ORDER BY quantityordered DESC;


-- soal 2
SELECT 
	customernumber, 
	customername, 
	country, 
	CONCAT(contactfirstname, ' ', contactlastname) AS "Nama Kontak", 
	creditlimit, (creditlimit - 10000) AS "Selisih Kredit" 
FROM customers

WHERE 
	country IN ('USA', 'Canada', 'France') AND 
	creditlimit > 30000
ORDER BY creditlimit DESC;


-- soal 3
SELECT
	productcode,
	productname,
	buyprice,
	msrp,
	GREATEST(buyprice, msrp) AS "Harga Tertinggi",
	LEAST(buyprice, msrp) AS "Harga Terendah"
FROM products

WHERE productname ILIKE '%car%';


-- soal 4
SELECT 
	ordernumber,
	orderdate,
	shippeddate,
	EXTRACT(YEAR FROM orderdate) AS "Tahun",
	EXTRACT(MONTH FROM orderdate) AS "Bulan",
	shippeddate - orderdate AS "Lama Pengiriman",
	AGE(shippeddate, orderdate) AS "Interval Pengiriman",
	CURRENT_TIME AS "Waktu Laporan",
	CURRENT_DATE AS "Tanggal Laporan"
FROM orders

WHERE shippeddate IS NOT NULL;


-- soal 5
SELECT
	ordernumber,
	orderdate, 
	shippeddate,
	orderdate + INTERVAL '10 days' AS " Estimasi Kirim",
	COALESCE(shippeddate, orderdate + INTERVAL '10 days') AS "Tanggal Aktual",
	AGE(shippeddate, orderdate) AS "Selisih Waktu"
FROM orders

WHERE 
	comments ILIKE '%customer%' AND 
	EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 AND
	ordernumber % 2 != 0
ORDER BY orderdate DESC;