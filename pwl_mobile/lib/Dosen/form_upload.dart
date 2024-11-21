import 'package:flutter/material.dart';
import 'upload.dart'; // Pastikan ini adalah path ke file yang berisi UploadScreen

class CertificationUploadForm extends StatefulWidget {
  final String jenis; // Tambahkan parameter 'jenis'
  
  // Constructor untuk menerima parameter 'jenis'
  CertificationUploadForm({required this.jenis});

  @override
  _CertificationUploadFormState createState() => _CertificationUploadFormState();
}

class _CertificationUploadFormState extends State<CertificationUploadForm> {
  final _formKey = GlobalKey<FormState>();
  String? _nomorSertifikasi;
  String? _tanggalPelaksanaan;
  String? _tanggalBerlaku;
  String? _namaKegiatan;
  String? _namaFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form ${widget.jenis}', // Mengganti judul berdasarkan jenis yang dipilih
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Warna ikon tombol back putih
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF1F4C97),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Membuat container minimal setinggi layar
          ),
          child: IntrinsicHeight( // Agar container mengisi penuh tinggi layar
            child: Container(
              color: Colors.white, // Latar belakang putih
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        widget.jenis, // Menampilkan jenis unggahan di tengah
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField('Nomor ${widget.jenis}', (value) {
                      _nomorSertifikasi = value;
                    }),
                    SizedBox(height: 20),
                    _buildTextField('Tanggal Pelaksanaan', (value) {
                      _tanggalPelaksanaan = value;
                    }),
                    SizedBox(height: 20),
                    _buildTextField('Tanggal Berlaku', (value) {
                      _tanggalBerlaku = value;
                    }),
                    SizedBox(height: 20),
                    _buildTextField('Nama Kegiatan', (value) {
                      _namaKegiatan = value;
                    }),
                    SizedBox(height: 20),
                    _buildFileUploadButton(context), // Kirim context untuk navigasi
                    Spacer(), // Menambahkan spacer agar tombol simpan ada di bagian bawah
                    SizedBox(height: 20), // Memberikan jarak antara isian form dan tombol
                    _buildSaveButton(context), // Tombol Simpan
                    SizedBox(height: 50), // Menambahkan sedikit jarak dari bawah layar
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onSaved: onSaved,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Harap isi bidang ini';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFileUploadButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Unggah Berkas',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          icon: Icon(Icons.cloud_upload, color: Colors.white),
          label: Text(
            'Tambah Berkas',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadScreen(
                  onFileUploaded: (String fileName) {
                    setState(() {
                      _namaFile = fileName; // Update _namaFile setelah upload
                    });
                  },
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1F4C97),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 10),
        if (_namaFile != null)
          Text(
            'File terpilih: $_namaFile',
            style: TextStyle(fontSize: 16),
          ),
        if (_namaFile == null)
          Text(
            'Tidak ada file terpilih',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Center( // Agar tombol berada di tengah
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5, // Lebar tombol 50% dari lebar layar
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Form berhasil disimpan')),
              );
            }
          },
          child: Text(
            'Simpan',
            style: TextStyle(color: Colors.white), // Teks putih
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1F4C97),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 16), // Menambah padding vertikal
          ),
        ),
      ),
    );
  }
}
