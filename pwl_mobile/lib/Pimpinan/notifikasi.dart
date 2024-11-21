import 'package:flutter/material.dart';
import '../Pimpinan/detail_notifikasi.dart'; // Pastikan file ini ada di project kamu

class NotifikasiPage extends StatefulWidget {
  @override
  _NotifikasiScreenState createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiPage> {
  bool _isTerbaruSelected = true;
  String? _selectedFilter = "Semua";

  // Contoh data notifikasi
  final List<Map<String, String>> notifikasiList = [
    {"pengirim": "Admin", "pesan": "Admin merekomendasikan pelatihan ini."},
    {"pengirim": "Dosen", "pesan": "[nama dosen] menerima rekomendasi pelatihan dari anda."},
    {"pengirim": "Admin", "pesan": "Admin mengirim pelatihan terbaru."},
    {"pengirim": "Dosen", "pesan": "[nama dosen] menerima rekomendasi pelatihan dari anda."},
  ];

  // Fungsi untuk memfilter notifikasi berdasarkan pilihan filter
  List<Map<String, String>> getFilteredNotifikasi() {
    if (_selectedFilter == "Semua") {
      return notifikasiList;
    } else {
      return notifikasiList.where((notifikasi) => notifikasi['pengirim'] == _selectedFilter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4C97),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Panah kembali putih
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifikasi",
          style: TextStyle(color: Colors.white), // Tulisan header notifikasi putih
        ),
      ),
      body: Container(
        color: Colors.white, // Background putih di belakang notifikasi
        child: Column(
          children: [
            // Row untuk Terbaru dan Semua
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTerbaruSelected = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: _isTerbaruSelected ? Color(0xFF1F4C97) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Terbaru",
                        style: TextStyle(
                          fontWeight: _isTerbaruSelected ? FontWeight.bold : FontWeight.normal,
                          color: _isTerbaruSelected ? Colors.white : Colors.black, // Ubah warna berdasarkan status
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTerbaruSelected = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: !_isTerbaruSelected ? Color(0xFF1F4C97) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Semua",
                        style: TextStyle(
                          fontWeight: !_isTerbaruSelected ? FontWeight.bold : FontWeight.normal,
                          color: !_isTerbaruSelected ? Colors.white : Colors.black, // Ubah warna berdasarkan status
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Kotak filter di bawah
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildFilterBox("Semua"),
                  SizedBox(width: 10), // Jarak antara kotak filter
                  _buildFilterBox("Admin"),
                  SizedBox(width: 10), // Jarak antara kotak filter
                  _buildFilterBox("Dosen"),
                ],
              ),
            ),
            // ListView untuk menampilkan notifikasi
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: getFilteredNotifikasi().length, // Jumlah notifikasi yang sudah difilter
                itemBuilder: (context, index) {
                  final notifikasi = getFilteredNotifikasi()[index]; // Notifikasi yang sudah difilter
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman detail ketika notifikasi ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // Menentukan nilai untuk namaDosen, isAccepted, dan alasan
                            String pengirim = notifikasi["pengirim"] ?? "Unknown";
                            bool? isAccepted = false; // Atur sesuai dengan logika aplikasi Anda
                            String alasan = "Tidak ada alasan"; // Atur sesuai dengan logika aplikasi Anda

                            // Contoh: Jika pengirim adalah Admin, kita bisa menyetujui
                            if (pengirim == "Admin") {
                              isAccepted = true; // Misalnya Admin menerima
                            }

                            return DetailNotifikasiPage(
                              namaDosen: pengirim, // Mengisi dengan nama pengirim
                              isAccepted: isAccepted, // Mengisi dengan status penerimaan
                              alasan: alasan, // Mengisi dengan alasan
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: _isTerbaruSelected ? Color(0xFFEDF6FF) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person),
                              ),
                              SizedBox(width: 10),
                              Text(
                                notifikasi["pengirim"] ?? "Unknown",
                                style: TextStyle(
                                  fontWeight: _isTerbaruSelected ? FontWeight.bold : FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            notifikasi["pesan"] ?? "Pesan tidak tersedia",
                            style: TextStyle(
                              fontWeight: _isTerbaruSelected ? FontWeight.bold : FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBox(String title) {
    bool isSelected = _selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = title; // Set filter yang dipilih
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Padding kecil untuk kotak filter
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1F4C97) : Colors.grey[200], // Warna background
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54, // Warna teks
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
