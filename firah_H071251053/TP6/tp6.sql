SET search_path TO "classicmodels";

-- 1
SELECT
	productcode,
	productname,
	MSRP,
	quantityinstock,
	CASE
		WHEN MSRP < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi' 
		WHEN MSRP < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah' 
		WHEN MSRP BETWEEN 50 AND 100 THEN 'Harga Menengah' 
		WHEN MSRP > 100 THEN 'Harga Premium' 
	END AS kategori_produk
FROM products
ORDER BY MSRP DESC;

-- 2
SELECT 
	productcode,
	SUM(quantityordered) AS total_unit_terjual,
	COUNT(DISTINCT ordernumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (
	SELECT AVG(quantityordered)
	FROM orderdetails
) AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

-- 3
SELECT
	productcode,
	productname,
	quantityinstock,
	MSRP
FROM products
WHERE quantityinstock > (
	SELECT AVG(quantityinstock)
	FROM products
) AND MSRP > (
	SELECT AVG(MSRP)
	FROM products
)
ORDER BY quantityinstock DESC;

-- 4
SELECT 
	ordernumber, 
	status
FROM orders
WHERE ordernumber = 10100;

BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- Soal tambahan
-- 3
SELECT * FROM products;

SELECT
	productcode,
	productname,
	productline,
	buyprice
FROM products
WHERE productline = 'Classic Cars' AND 
	buyprice > ALL (
	SELECT buyprice
	FROM products
	WHERE productline = 'Vintage Cars'
)
ORDER BY buyprice DESC;
