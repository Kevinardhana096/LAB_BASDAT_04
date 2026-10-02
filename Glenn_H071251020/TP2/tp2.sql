-- DATA AWAL
CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3,2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);

INSERT INTO prodi(nama_prodi)
VALUES 
	('Sistem Informasi'),
	('Fisika'),
	('Kimia')
;

INSERT INTO mahasiswa
VALUES  
	('H071251001', 'Paulo Dybala', 3.50, 'dybala@gmail.com', 3),
	('H071251002', 'Lautaro Martinez', 3.50, 'martinez@gmail.com', 1)
;

-- TUGAS PRAKTIKUM 2
-- NOMOR 1-2 menggunakan database praktikum_db
-- 1.
INSERT INTO mahasiswa
	(nim, nama, email, id_prodi )
VALUES 
	('H071251020', 'Glenn Robean', 'glenn@gmail.com', 1),
	('H071251010', 'Cristiano Ronaldo', NULL, 3),
	('H071251030', 'Lionel Messi', 'messi@gmail.com', 2)
;

SELECT * FROM mahasiswa;

-- 2.
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa;


-- NOMOR 3-5 menggunakan database classicmodels
SET search_path TO "classicmodels", public;

-- 3.
SELECT
	customernumber AS "Nomor Pelanggan",
	customername AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
FROM
	customers;

-- 4.
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- 5.
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5;
		












