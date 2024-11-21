import 'package:flutter/material.dart';
import 'form_upload.dart'; // Import halaman form_upload

class JenisUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data',
          style: TextStyle(color: Colors.white), // Warna teks diubah menjadi putih
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFF1F4C97),
      ),
      body: Stack(
        children: [
          // Latar belakang putih bersih
          Container(
            color: Colors.white,
          ),
          // Set lingkaran atas
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEDF6FF),
              ),
            ),
          ),
          // Set lingkaran bawah
          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEDF6FF),
              ),
            ),
          ),
          // Konten di tengah
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Box Sertifikasi
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150, // Ukuran tombol
                  height: 200, // Ukuran tinggi tombol
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CertificationUploadForm(jenis: 'Sertifikasi'),
                        ),
                      );
                    },
                    child: Text(
                      'Sertifikasi',
                      style: TextStyle(color: Colors.white), // Ubah teks menjadi putih
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F4C97), // Latar belakang biru tua
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Atur lengkungan di sini
                      ),
                    ),
                  ),
                ),
                // Box Pelatihan
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150, // Ukuran tombol
                  height: 200, // Ukuran tinggi tombol
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CertificationUploadForm(jenis: 'Pelatihan'),
                        ),
                      );
                    },
                    child: Text(
                      'Pelatihan',
                      style: TextStyle(color: Colors.white), // Ubah teks menjadi putih
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1F4C97), // Latar belakang biru tua
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Atur lengkungan di sini
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
