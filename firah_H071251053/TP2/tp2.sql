-- tabel untuk no. 1 & 2
CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	nama_prodi VARCHAR(100) NOT NULL
); 

CREATE TABLE mahasiswa ( 
	nim VARCHAR(10) PRIMARY KEY, 
	nama VARCHAR(100) NOT NULL, 
	ipk NUMERIC(3, 2) DEFAULT 0.00, 
	email VARCHAR(150) UNIQUE, 
	id_prodi INT, 
	CONSTRAINT fk_mahasiswa_prodi 
		FOREIGN KEY (id_prodi) 
		REFERENCES prodi (id)
);

INSERT INTO prodi (nama_prodi)
VALUES ('Sistem Informasi')
RETURNING*;

-- 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
	('H071251053', 'Firah Nuraisyah', 'firah@gmail.com', 1),
	('H071251007', 'Nurhayu Fiantika Gafar', 'nurhayu@gmail.com', 1),
	('H071251019', 'Fadhiyah Syafikah Firman', NULL, 1);
RETURNING*;
	
-- 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING*;

UPDATE mahasiswa
SET ipk = 3.65
WHERE ipk = 0.00
RETURNING*;

DELETE FROM mahasiswa
WHERE email IS NULL
RETURNING*;

SELECT * FROM mahasiswa;

-- no 3 - 5
SET search_path TO "classicmodels";

-- 3
SELECT 
	customernumber AS "Nomor Pelanggan", 
	customername AS "Nama Pelanggan", 
	phone AS "Telepon", 
	country AS "Negara" 
FROM customers;

-- 4
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;

-- live coding
SELECT DISTINCT status AS "Status Pesanan" FROM orders
WHERE status != 'Canclelled'
ORDER BY status DESC
LIMIT 3 OFFSET 1;





