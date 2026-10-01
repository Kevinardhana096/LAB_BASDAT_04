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
		REFERENCES prodi(id)
);

SELECT * FROM prodi

INSERT INTO prodI (nama_prodi)
VALUES 
	('Sistem Informasi'),
	('Aktuaria'),
	('Matematika');

INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES 
	('H071251018', 'Farhan', 'farhan@gmail.com', 1),
	('H071251017', 'Alif', NULL, 1),
	('H071251016', 'Fatur', 'fatur@email.com', 1)
	
SELECT * FROM mahasiswa;

INSERT INTO mahasiswa (nim, nama, email, ipk, id_prodi)
VALUES 
	('H071251020', 'Eriz', 'eriz@gmail.com', 3.50, 1)

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = < 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

INSERT INTO mahasiswa (nim, nama, email, ipk, id_prodi)
VALUES 
	('H071251023', 'Eri', 'eri@gmail.com', 3.20, 1)
RETURNING *;







