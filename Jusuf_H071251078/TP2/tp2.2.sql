set search_path TO classicmodels;

-- Soal 3
SELECT
    customerNumber AS "Nomor Pelanggan",
	customerName AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM customers;

-- Soal 4
SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- Soal 5
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;