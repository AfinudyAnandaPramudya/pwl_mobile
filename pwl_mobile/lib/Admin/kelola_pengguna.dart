import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'agenda_kegiatan.dart';

class KelolaPenggunaPage extends StatefulWidget {
  const KelolaPenggunaPage({super.key, required kegiatanId});

  @override
  _KelolaPenggunaPageState createState() => _KelolaPenggunaPageState();
}

class _KelolaPenggunaPageState extends State<KelolaPenggunaPage> {
  final Dio _dio = Dio();
  final String baseUrl = 'http://127.0.0.1:8000/api/kelola_pengguna';
  List<dynamic> kegiatanList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKegiatan();
  }

  Future<void> _fetchKegiatan() async {
    try {
      final response = await _dio.get(baseUrl);
      setState(() {
        kegiatanList = response.data['data'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Kelola Pengguna'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : kegiatanList.isEmpty
              ? const Center(child: Text('Tidak ada data kegiatan'))
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: kegiatanList.length,
                  itemBuilder: (context, index) {
                    final kegiatan = kegiatanList[index];
                    return KegiatanItem(
                      category: kegiatan['jenis_kegiatan']?['nama_jenis_kegiatan'] ??
                          'Tidak ada Kegiatan',
                      title: kegiatan['nama_kegiatan'] ?? 'Tidak ada nama',
                      institution: kegiatan['tanggal']?['tanggal_mulai'] ?['tanggal_selesai']?['bobot_kerja']?['bobot_kerja']??
                          'Tidak ada ',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KelolaPenggunaPage(
                                kegiatanId: kegiatan['kegiatan_id']),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

// Widget untuk menampilkan setiap item kegiatan
class KegiatanItem extends StatelessWidget {
  final String category;
  final String title;
  final String institution;
  final VoidCallback? onTap;

  const KegiatanItem({
    super.key,
    required this.category,
    required this.title,
    required this.institution,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBE8FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  institution,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
