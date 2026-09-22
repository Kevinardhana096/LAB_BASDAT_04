# LAB_BASDAT_04

Panduan lengkap tata cara pengumpulan tugas praktikum Basis Data, mulai dari melakukan *fork* repositori hingga pengajuan *Pull Request*.

---

## 📌 Ketentuan Penamaan & Struktur Repositori

Setiap mahasiswa wajib mematuhi format penamaan branch, struktur folder, dan file tugas berikut:

### 1. Format Penamaan Branch
```text
<nama>_<nim>
```
> **Contoh:** `budi_12345678`

---

### 2. Struktur Folder & File Tugas
Di dalam repositori, setiap mahasiswa membuat folder dengan nama identitasnya masing-masing, kemudian di dalamnya terdapat folder tugas (`TP1`, `TP2`, dst.) dan file tugas yang dikumpulkan:

```text
LAB_BASDAT_04/
└── <nama>_<nim>/
    ├── TP1/
    │   └── tp1 (file tugas TP1)
    ├── TP2/
    │   └── tp2 (file tugas TP2)
    └── ...
```

**Ketentuan:**
- **Folder Mahasiswa:** `<nama>_<nim>` (contoh: `budi_12345678`)
- **Folder Tugas:** `TP<nomor>` (huruf kapital, contoh: `TP1`, `TP2`, `TP3`)
- **File Tugas:** `tp<nomor>` (contoh: `tp1`, `tp1.sql`, atau sesuai format tugas yang diinstruksikan)

---

## 🚀 Panduan Lengkap Langkah-Langkah (Step-by-Step)

### Step 1: Fork Repositori
1. Buka repositori utama di GitHub: [Kevinardhana096/LAB_BASDAT_04](https://github.com/Kevinardhana096/LAB_BASDAT_04).
2. Klik tombol **"Fork"** di pojok kanan atas halaman.
3. Pilih akun GitHub Anda dan klik **"Create fork"**. Sekarang repositori telah disalin ke akun pribadi Anda.

---

### Step 2: Clone Repositori ke Komputer Lokal
Buka terminal / Git Bash di komputer Anda, lalu jalankan:
```bash
git clone https://github.com/<username-github-anda>/LAB_BASDAT_04.git
cd LAB_BASDAT_04
```
*(Ganti `<username-github-anda>` dengan username akun GitHub Anda).*

---

### Step 3: Tambahkan Remote Upstream (Disarankan)
Hubungkan repositori lokal Anda ke repositori utama agar mudah melakukan sinkronisasi materi/update terbaru:
```bash
git remote add upstream https://github.com/Kevinardhana096/LAB_BASDAT_04.git
```

Sebelum mulai mengerjakan tugas baru, pastikan branch `main` Anda selalu tersinkronisasi:
```bash
git checkout main
git pull upstream main
git push origin main
```

---

### Step 4: Buat dan Berpindah ke Branch Baru
Buat branch dengan format `<nama>_<nim>`:
```bash
git checkout -b budi_12345678
```

---

### Step 5: Buat Struktur Folder & Letakkan File Tugas
Buat folder nama Anda dan subfolder tugas di dalamnya:
1. Buat folder `<nama>_<nim>` (contoh: `budi_12345678`).
2. Di dalam folder tersebut, buat folder `TP<nomor>` (contoh: `TP1`).
3. Simpan file tugas Anda di dalam folder tersebut dengan nama `tp<nomor>` (contoh: `tp1` atau `tp1.sql`).

**Perintah cepat via terminal (Git Bash / Linux / macOS):**
```bash
# Contoh untuk TP1:
mkdir -p budi_12345678/TP1
```
*(Atau buat folder secara manual lewat File Explorer / VS Code).*

**Hierarki yang terbentuk:**
```text
budi_12345678/
└── TP1/
    └── tp1
```

---

### Step 6: Commit Perubahan
Tambahkan folder Anda dan lakukan commit:
```bash
# Contoh untuk TP1:
git add budi_12345678/
git commit -m "Submit TP1 - Budi 12345678"
```

---

### Step 7: Push Branch ke Repositori Fork
Kirim branch Anda ke repositori fork di GitHub:
```bash
git push -u origin budi_12345678
```

---

### Step 8: Buat Pull Request (PR)
1. Buka halaman repositori fork Anda di browser GitHub.
2. Klik tombol **"Compare & pull request"** yang muncul di bagian atas (atau masuk ke menu **Pull Requests** -> **New pull request**).
3. Pastikan konfigurasi branch:
   - **Base repository:** `Kevinardhana096/LAB_BASDAT_04` (base: `main`)
   - **Head repository:** `<username-github-anda>/LAB_BASDAT_04` (compare: `<nama>_<nim>`)
4. Beri judul Pull Request dengan format:
   ```text
   Submit TP<nomor> - <Nama Lengkap> (<NIM>)
   ```
   > **Contoh:** `Submit TP1 - Budi Santoso (12345678)`
5. Klik **"Create pull request"**.

---

## ⚠️ Catatan Penting
- **Jangan bekerja langsung di branch `main`**. Selalu gunakan branch `<nama>_<nim>`.
- Selalu letakkan pengerjaan Anda di dalam folder identitas Anda sendiri (`<nama>_<nim>/TP<nomor>/`). Jangan mengubah atau menghapus folder milik orang lain.
- Pastikan file tugas dan kueri/kode sudah diuji dan berjalan dengan baik sebelum melakukan push.