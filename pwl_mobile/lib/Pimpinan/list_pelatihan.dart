import 'package:flutter/material.dart';
import 'detail_pelatihan.dart'; // Pastikan file detail_pelatihan.dart diimpor

class ListPelatihanPage extends StatefulWidget {
  const ListPelatihanPage({super.key});

  @override
  _ListPelatihanPageState createState() => _ListPelatihanPageState();
}

class _ListPelatihanPageState extends State<ListPelatihanPage> {
  bool isTersediaSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,



      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97), 
        foregroundColor: Colors.white,
        title: const Text('List Pelatihan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // List of Pelatihan
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                PelatihanItem(
                  category: 'Business Management',
                  title: 'Perancangan Pemasaran Online',
                  institution: 'BNSP',
                ),
                PelatihanItem(
                  category: 'Data Science',
                  title: 'Associate Data Scientist',
                  institution: 'LSP Digital',
                ),
                PelatihanItem(
                  category: 'Web Developer',
                  title: 'Junior Web Developer',
                  institution: 'BPPTIK',
                  onTap: () {
                    // Navigasi ke halaman detail pelatihan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPelatihanPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan setiap item pelatihan
class PelatihanItem extends StatelessWidget {
  final String category;
  final String title;
  final String institution;
  final VoidCallback? onTap; // Tambahkan onTap sebagai parameter opsional

  const PelatihanItem({
    super.key,
    required this.category,
    required this.title,
    required this.institution,
    this.onTap, // Inisialisasi onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Menggunakan InkWell untuk mendeteksi klik
      onTap: onTap, // Fungsi onTap yang dieksekusi saat item diklik
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
              offset: const Offset(0, 3), // Position of the shadow
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
                    color: Color(0xFFDBE8FD),
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
