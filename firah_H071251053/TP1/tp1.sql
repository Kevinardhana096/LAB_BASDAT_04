CREATE DATABASE db_rs_sejahtera

CREATE TABLE poliklinik (
	id SERIAL PRIMARY KEY, 
	nama_poli VARCHAR(50) NOT NULL UNIQUE, 
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
	id SERIAL PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE, 
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L', 'P'))
);

CREATE TABLE dokter (
	id SERIAL PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT DEFAULT 0,
	id_poli INT,
	CONSTRAINT dokter_poliklinik
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik(id)
);

CREATE TABLE rekam_medis (
	id SERIAL PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(12, 2) DEFAULT 150000, 
	id_pasien INT,
	CONSTRAINT rekam_medis_pasien
		FOREIGN KEY (id_pasien)
		REFERENCES pasien(id),
	id_dokter INT,
	CONSTRAINT rekam_medis_dokter
		FOREIGN KEY (id_dokter)
		REFERENCES dokter(id)
);

CREATE TABLE resep_obat (
	id_resep SERIAL PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT DEFAULT 1,
	id_rm INT,
	CONSTRAINT resep_obat_rekam_medis
		FOREIGN KEY (id_rm)
		REFERENCES rekam_medis(id)
); 

SELECT constraint_name, constraint_type, table_name
FROM information_schema.table_constraints
WHERE table_schema = 'public';

SELECT Column_name, data_type,
character_maximum_length, numeric_precision, numeric_scale,
is_nullable, column_default
from information_schema.columns
WHERE table_schema = 'public' AND table_name = 'reep_obat'
ORDER BY ordinal_position;

-- 2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat 
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;

ALTER TABLE resep_obat 
ADD CONSTRAINT jumlah_obat
	CHECK (jumlah > 0);

-- 3
DROP TABLE resep_obat;
DROP TABLE rekam_medis;
