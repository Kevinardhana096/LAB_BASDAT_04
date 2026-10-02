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
        REFERENCES prodi (id)
);

INSERT INTO prodi (nama_prodi)
VALUES ('Sistem Informasi')
RETURNING *;

-- Soal 1
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
    ('H069', 'Aditya Izza F', 'erza@gmail.com', 1),
    ('H074', 'Patricius Reinhard D', 'patri@gmail.com', 1),
    ('H077', 'M Daffa Athaillah', NULL, 1)
RETURNING *;

-- Soal 2
UPDATE mahasiswa
SET ipk = 3.50
WHERE nim = 'H069'
RETURNING *;

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50
RETURNING *;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa;