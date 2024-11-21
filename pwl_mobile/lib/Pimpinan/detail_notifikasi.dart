import 'package:flutter/material.dart';

class DetailNotifikasiPage extends StatelessWidget {
  final String namaDosen;
  final bool? isAccepted; // Status apakah rekomendasi diterima atau tidak
  final String alasan; // Alasan jika rekomendasi ditolak

  DetailNotifikasiPage({
    required this.namaDosen,
    this.isAccepted,
    this.alasan = "",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          "Notifikasi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity, // Memastikan lebar penuh
        height: double.infinity, // Memastikan tinggi penuh
        color: Colors.white, // Latar belakang putih bersih
        child: Stack(
          children: [
            // Latar belakang hitam transparan
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
            Center(
              child: Container(
                width: 300,
                padding: EdgeInsets.all(30), // Memperlebar konten ke bawah
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lingkaran dengan ikon notifikasi
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.blue[800]!, width: 2),
                      ),
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Menampilkan nama dosen
                    Text(
                      "Dosen $namaDosen",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500, // Medium bold
                      ),
                    ),
                    SizedBox(height: 5),
                    // Menampilkan status rekomendasi
                    Text(
                      isAccepted == true
                          ? "telah menerima rekomendasi pelatihan dari Anda"
                          : "telah menolak rekomendasi pelatihan dari Anda",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Menampilkan alasan jika tidak diterima
                    if (isAccepted == false && alasan.isNotEmpty)
                      Text(
                        "Alasan: $alasan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    SizedBox(height: 20),
                    // Tombol OK
                    ElevatedButton(
                      onPressed: () {
                        // Logika untuk menutup notifikasi
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800], // Latar biru
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
