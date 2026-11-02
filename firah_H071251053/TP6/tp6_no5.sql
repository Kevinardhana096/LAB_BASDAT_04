-- 5
CREATE TABLE anggota (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE, 
	denda INT DEFAULT 0,
	id_anggota INT,
	CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
	id_buku INT,
	CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id)
);

CREATE INDEX index_buku_genre
ON buku(genre);

CREATE INDEX index_anggota_kota_domisili
ON anggota(kota_domisili);

SELECT id, judul_buku, genre
FROM buku
WHERE genre = 'Fantasy';

DROP INDEX index_buku_genre;

-- Soal tambahan
-- 6
CREATE TABLE kurir (
	id SERIAL PRIMARY KEY,
	nama_kurir VARCHAR(50) NOT NULL,
	no_telepon VARCHAR(20) UNIQUE,
	status_aktif BOOLEAN DEFAULT 'TRUE'
);

CREATE TABLE pengiriman (
	id SERIAL PRIMARY KEY,
	nomor_resi VARCHAR(30) NOT NULL UNIQUE,
	id_kurir INT,
	CONSTRAINT fk_pengiriman_kurir
		FOREIGN KEY (id_kurir)
		REFERENCES kurir(id),
	tanggal_kirim TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	ongkos_kirim NUMERIC(12,2) NOT NULL CHECK (ongkos_kirim > 0),
	status_pengiriman VARCHAR(20) DEFAULT 'Dalam Perjalanan'
);

CREATE INDEX idx_pengiriman_kurir
ON pengiriman(id_kurir);

CREATE INDEX idx_pengiriman_status
ON pengiriman(status_pengiriman);

DROP INDEX idx_pengiriman_status;










