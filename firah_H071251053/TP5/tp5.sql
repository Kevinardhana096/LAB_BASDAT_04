SET search_path TO "classicmodels";

-- 1
SELECT
	c.contactfirstname,
	c.customername,
	of.city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e
	ON e.employeenumber = c.salesrepemployeenumber
JOIN offices AS of
	ON of.officecode = e.officecode
WHERE
	c.contactfirstname ILIKE 'A%' AND
	of.city != 'NYC'
ORDER BY c.customername;

-- 2
SELECT
	c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
	ON c.customernumber = p.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY SUM(p.amount) DESC;

-- 3
SELECT
	c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING
	COUNT(DISTINCT o.ordernumber) > 3 AND
	AVG(od.quantityordered) > 35
ORDER BY 
	total_order DESC, 
	avg_quantity_per_order DESC;

-- 4
SELECT
    pr.productline,
    SUM(od.quantityordered) AS total_terjual,
    ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
    ROUND(AVG((pr.MSRP - od.priceeach) / pr.MSRP * 100), 2) AS avg_discount_percentage
FROM products AS pr
JOIN orderdetails AS od
    ON pr.productcode = od.productcode
GROUP BY pr.productline
HAVING
    SUM(od.quantityordered) > 3000 AND 
	AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- 5 
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT o.ordernumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
JOIN orders AS o
    ON c.customernumber = o.customernumber
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
WHERE o.status = 'Shipped'
GROUP BY c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT
    c.customername,
    c.city AS customer_city,
    ofc.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers AS c
JOIN employees AS e
    ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS ofc
    ON e.officecode = ofc.officecode
JOIN orders AS o
    ON c.customernumber = o.customernumber
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
WHERE ofc.territory = 'EMEA'
GROUP BY
    c.customername,
    c.city,
    ofc.city
HAVING
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2 AND 
	SUM(od.quantityordered) > 1000 AND 
	SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;

-- Study Case
-- 1
SELECT
	c.customername AS "Nama Konsumen",
	o.ordernumber AS "Nomor Nota",
	(o.shippeddate - o.requireddate) AS "Selisih Keterlambatan",
	SUM(od.quantityordered * od.priceeach) AS "Total Tagihan"
FROM customers AS c
JOIN orders AS o
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON o.ordernumber = od.ordernumber
WHERE 
	o.shippeddate > requireddate AND 
	EXTRACT(YEAR FROM o.orderdate) = 2004
GROUP BY 
	c.customername,
	o.ordernumber,
	o.shippeddate, 
	o.requireddate
HAVING 
	SUM(od.quantityordered * od.priceeach) > 25000
ORDER BY 
	"Selisih Keterlambatan" DESC,
	"Total Tagihan" DESC;

-- 2
SELECT 
    of.city AS "Kota Cabang",
    p.productline AS "Kategori Barang",
    SUM(od.quantityordered) AS "Volume Barang",
    SUM(od.quantityordered * od.priceeach) AS "Pendapatan Kotor"
FROM offices AS of
JOIN employees AS e 
	ON of.officecode = e.officecode
JOIN customers AS c 
	ON e.employeenumber = c.salesrepemployeenumber
JOIN orders AS o 
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od 
	ON o.ordernumber = od.ordernumber
JOIN products AS p 
	ON od.productcode = p.productcode
WHERE of.country = 'USA'
GROUP BY 
	of.city, 
	p.productline
HAVING SUM(od.quantityordered) > 1500
ORDER BY 
	"Kota Cabang" ASC, 
	"Pendapatan Kotor" DESC;

-- 3
SELECT 
	c.customernumber AS "Kode Mitra", 
	c.customername AS "Nama Mitra"
FROM customers AS c
JOIN orders AS o 
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od 
	ON o.ordernumber = od.ordernumber
JOIN products AS p 
	ON od.productcode = p.productcode
WHERE p.productline = 'Classic Cars'

EXCEPT

SELECT 
	c.customernumber AS "Kode Mitra", 
	c.customername AS "Nama Mitra"
FROM customers AS c
JOIN orders AS o 
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od 
	ON o.ordernumber = od.ordernumber
JOIN products AS p 
	ON od.productcode = p.productcode
WHERE p.productLine = 'Vintage Cars'
ORDER BY "Nama Mitra" ASC;

-- 4
SELECT 
    c.customername AS "Nama Klien",
    c.city AS "Kota Domisili",
    c.creditlimit AS "Plafon Pagu",
    COALESCE(SUM(p.amount), 0) AS "Akumulasi Setoran",
    COUNT(p.checknumber) AS "Frekuensi Bayar"
FROM customers AS c
LEFT JOIN payments AS p 
	ON c.customernumber = p.customernumber
GROUP BY 
	c.customernumber, 
	c.customername, 
	c.city, 
	c.creditlimit
HAVING 
	c.creditlimit > 75000 AND 
	COALESCE(SUM(p.amount), 0) < 30000
ORDER BY "Plafon Pagu" DESC;

-- 5
SELECT 
    e.employeenumber AS "ID Pegawai",
    CONCAT(e.firstname, ' ', e.lastname) AS "Nama Penjual",
    COUNT(DISTINCT c.customernumber) AS "Jumlah Mitra Binaan",
    COUNT(DISTINCT o.ordernumber) AS "Pesanan Tuntas"
FROM employees AS e
JOIN customers AS c 
	ON e.employeenumber = c.salesrepemployeenumber
JOIN orders AS o 
	ON c.customernumber = o.customernumber
WHERE 
	e.jobtitle LIKE '%Sales Rep%' AND 
	o.status = 'Shipped'
GROUP BY 
	e.employeenumber, 
	e.firstname, 
	e.lastname
HAVING 
	COUNT(DISTINCT c.customernumber) > 5 AND 
	COUNT(DISTINCT o.ordernumber) >= 15
ORDER BY "Pesanan Tuntas" DESC;

-- 6
SELECT 
    c.country AS "Negara Tujuan",
    COUNT(DISTINCT o.ordernumber) AS "Volume Nota",
    AVG(o.shippeddate - o.orderdate) AS "Rataan Durasi Kirim",
    STRING_AGG(DISTINCT p.productline, ', ') AS "Koleksi Kategori"
FROM customers AS c
JOIN orders AS o 
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od 
	ON o.ordernumber = od.ordernumber
JOIN products AS p 
	ON od.productcode = p.productcode
WHERE 
	EXTRACT(YEAR FROM o.orderdate) = 2003 AND 
	o.status = 'Shipped'
GROUP BY c.country
HAVING 
	AVG(o.shippeddate - o.orderdate) > '3 days' AND 
	COUNT(DISTINCT o.ordernumber) > 5
ORDER BY "Rataan Durasi Kirim" DESC;



