-- 1.1.
CREATE DATABASE db_rs_sejahtera;

-- 1.2.A.
CREATE TABLE poliklinik (
    id_poli SERIAL PRIMARY KEY,
    nama_poli VARCHAR(50) NOT NULL UNIQUE,
    gedung VARCHAR(50) NOT NULL
);

-- 1.2.B.
CREATE TABLE pasien (
    id_pasien SERIAL PRIMARY KEY,
    nik VARCHAR(16) NOT NULL UNIQUE,
    nama_pasien VARCHAR(150) NOT NULL,
    jenis_kelamin VARCHAR(1) CHECK (jenis_kelamin IN ('L', 'P'))
);

-- 1.2.C.
CREATE TABLE doktor (
    id_dokter SERIAL PRIMARY KEY,
    nama_dokter VARCHAR(150) NOT NULL,
    no_izin_praktek VARCHAR(30) UNIQUE,
    pengalaman_tahun INT DEFAULT 0 CHECK (pengalaman_tahun >= 0),
    id_poli INT,
	CONSTRAINT fk_id_poli
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik(id_poli)
);

-- 1.2.D.
CREATE TABLE rekam_medis (
    id_rm SERIAL PRIMARY KEY,
    keluhan TEXT NOT NULL,
    biaya_pemeriksaan NUMERIC DEFAULT 150000,
    id_pasien INT,
	CONSTRAINT fk_id_pasien
		FOREIGN KEY (id_pasien)
		REFERENCES pasien(id_pasien),
    id_dokter INT,
	CONSTRAINT fk_id_dokter
		FOREIGN KEY (id_dokter)
		REFERENCES doktor(id_dokter)
);

-- 1.2.E.
CREATE TABLE resep_obat (
    id_resep SERIAL PRIMARY KEY,
    nama_obat VARCHAR(100) NOT NULL,
    jumlah INT CHECK (jumlah > 0),
    id_rm INT, 
	CONSTRAINT fk_id_rm
		FOREIGN KEY (id_rm)
		REFERENCES rekam_medis(id_rm)
);

-- Study Case Tambahan
ALTER TABLE resep_obat
DROP CONSTRAINT fk_id_rm;

-- 2.1.
ALTER TABLE pasien 
ADD COLUMN gol_darah VARCHAR(2);

-- 2.2.
ALTER TABLE resep_obat 
ALTER COLUMN nama_obat TYPE TEXT;

-- 2.3.
ALTER TABLE poliklinik 
DROP COLUMN gedung;

3.1.
DROP TABLE resep_obat;

3.2.
DROP TABLE rekam_medis;


