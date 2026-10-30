SET search_path TO 'classicmodels';

-- TUGAS PRAKTIKUM 6
-- SOAL TAMBAHAN
-- 1
SELECT
	customerNumber,
	customerName,
	city AS kota_domisili,
	(
		SELECT COUNT(*) 
		FROM orders
		WHERE customers.customerNumber = orders.customerNumber
	) AS total_pesanan,
	CASE 
		WHEN 
			(	SELECT COUNT(*) 
				FROM orders
				WHERE customers.customerNumber = orders.orderNumber
			) > 5 THEN 'Pelanggan Loyal'
		WHEN 
			(	SELECT COUNT(*) 
				FROM orders
				WHERE customers.customerNumber = orders.orderNumber
			)>= 2 THEN 'Pelangan Aktif'
		WHEN
			(	SELECT COUNT(*) 
				FROM orders
				WHERE customers.customerNumber = orders.orderNumber
			) = 1 THEN 'Pelanggan Baru'
		ELSE 'Pelanggan Pasif'
	END AS status_loyalitas
FROM customers
ORDER BY total_pesanan DESC, customerName ASC;

-- 2
SELECT 
	productCode,
	productName,
	productLine,
	buyPrice
FROM products
WHERE productLine = 'Classic Cars' AND buyPrice > ALL (
	SELECT buyPrice
	FROM products
	WHERE productLine = 'Vintage Cars'
)
ORDER BY buyPrice DESC;