-- TUGAS PRAKTIKUM 3

SET search_path TO "classicmodels";

-- 1
SELECT orderNumber, UPPER(productCode) AS "Kode Produk", quantityOrdered, priceEach
FROM orderdetails
WHERE (quantityOrdered BETWEEN 20 AND 50 or priceEach < 30) AND productCode LIKE 'S18%'
ORDER BY quantityOrdered DESC;

-- 2
SELECT customerNumber, customerName, country, 
CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak", 
creditLimit, 
(creditLimit - 10000) AS "Selisih Kredit" 
FROM customers
WHERE (country LIKE 'USA' OR country LIKE 'Canada' OR country LIKE 'France') AND creditLimit > 30000
ORDER BY creditLimit DESC;

-- 3
SELECT productCode, productName, buyPrice, MSRP, 
GREATEST(buyPrice, MSRP) AS "Harga Tertinggi", 
LEAST(buyPrice, MSRP) AS "Harga Terendah"
FROM products
WHERE productName ILIKE '%car%';

-- 4
SELECT orderNumber, orderDate, shippedDate, 
EXTRACT(YEAR FROM orderDate) AS "Tahun", 
EXTRACT(MONTH FROM orderDate) AS "Bulan", 
(shippedDate - orderDate) AS "Lama Pengiriman", 
((EXTRACT(DAY FROM (shippedDate - orderDate))) * INTERVAL '1 day') AS "Interval Pengiriman", 
CURRENT_DATE AS "Tanggal Laporan", 
CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippedDate IS NOT NULL;

-- 5
SELECT orderNumber, orderDate, shippedDate,
orderDate + INTERVAL '10 days' AS "Estimasi Kirim",
COALESCE(shippedDate, orderDate + INTERVAL '10 days') AS "Tanggal Aktual",
(shippedDate - orderDate) AS "Selisih Waktu"
FROM orders
WHERE (comments ILIKE '%customer%') AND (EXTRACT(MONTH FROM(orderDate)) BETWEEN 10 AND 12) AND (orderNumber % 2 = 1)
ORDER BY orderDate DESC;

-- SOAL TAMBAHAN
SELECT employeeNumber, firstName, lastName, jobTitle, email, 
UPPER(CONCAT(firstName, ' ', lastName)) AS "Nama Lengkap"
FROM employees
WHERE (jobTitle LIKE 'Sales Rep' OR jobTitle LIKE 'VP Sales') AND employeeNumber > 1200
ORDER BY lastName ASC;


