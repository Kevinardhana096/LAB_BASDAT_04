SET search_path TO 'classicmodels';

-- TUGAS PRAKTIKUM 4
-- 1
SELECT 
    customerNumber, 
    SUM(amount) AS total_dana, 
    COUNT(checkNumber) AS frekuensi_transaksi, 
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(checkNumber) > 4 AND AVG(amount) > 20000;

-- 2
SELECT 
    customerNumber, 
    SUM(amount) AS total_keseluruhan_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_keseluruhan_setoran DESC;

-- 3
SELECT
	productLine,
	COUNT(productName) AS jumlah_ragam_produk,
	ROUND(AVG(msrp), 2) AS rata_rata_hargaJualRitel,
	STRING_AGG(productName, ', ') AS daftar_nama_produk
FROM products
GROUP BY productLine
HAVING COUNT(productName) > 10;

-- 4
-- Himpunan 1: Daftar Atasan/Manajer
SELECT employeeNumber, jobTitle
FROM employees
WHERE reportsTo IS NOT NULL

EXCEPT

-- Himpunan 2: Jabatan Eksekutif Puncak
SELECT employeeNumber, jobTitle
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

SELECT employeeNumber, reportsTo, jobTitle FROM employees;

-- 5
SELECT 
    productCode, 
    SUM(quantityOrdered) AS total_unit, 
    ROUND(AVG(priceEach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit DESC;

-- 6
SELECT 
    productCode, 
    SUM(quantityOrdered) AS total_unit, 
    SUM(quantityOrdered * priceEach) AS pendapatan_kotor, 
    ROUND(AVG(priceEach), 2) AS rata_rata_harga, 
    MAX(priceEach) - MIN(priceEach) AS volatilitas_harga
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;

-- 7
(
    -- Himpunan Klien Elit
    SELECT customerNumber FROM customers WHERE creditLimit > 80000
    
    INTERSECT
    
    -- Himpunan Klien Bermasalah
    SELECT customerNumber FROM orders WHERE status IN ('Cancelled', 'On Hold')
)

EXCEPT

-- Himpunan Klien Loyal
SELECT customerNumber 
FROM payments 
GROUP BY customerNumber 
HAVING SUM(amount) > 100000;

-- SOAL TAMBAHAN
-- 1
SELECT 
	COUNT(productCode) AS jumlah_seluruh_produk,
	SUM(quantityInStock) AS total_stok_fisik,
	ROUND(AVG(buyPrice), 2) AS rataRata_hargaBeli,
	MIN(buyPrice) AS hargaBeli_termurah,
	MAX(buyPrice) AS hargaBeli_termahal
FROM products;

-- 2
SELECT
	country,
	COUNT(customerNumber) AS jumlah_pelanggan
FROM customers
GROUP BY country
ORDER BY jumlah_pelanggan DESC
LIMIT 5;


	




