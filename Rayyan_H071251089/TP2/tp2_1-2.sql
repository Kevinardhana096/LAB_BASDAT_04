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


-- soal 1 --
INSERT INTO prodi (nama_prodi)
VALUES
    ('Sistem Informasi'),
    ('Informatika'),
    ('Teknik Komputer');

INSERT INTO mahasiswa 
	(nim, nama, email, id_prodi)
VALUES 
	('A0011223', 'Adit', 'adit@gmail.com', 1),
	('C0011225', 'Bambang', NULL, 3),
	('B0011224', 'Rayyan', 'rayyan@gmail.com', 2);

-- soal 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;
--


SELECT * FROM mahasiswa;

DELETE FROM mahasiswa;