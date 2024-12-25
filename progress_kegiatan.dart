import 'package:flutter/material.dart';
import 'detail_progress.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  // Data progres dengan detail untuk setiap kegiatan
  final List<Map<String, dynamic>> progressList = [
    {
      'id': 1,
      'title': 'Porseni',
      'details': {
        'deskripsi': 'Kegiatan olahraga dan seni antar mahasiswa.',
        'status': 'Selesai',
        'tanggal_mulai': '01-03-2024',
        'tanggal_selesai': '05-03-2024',
      },
    },
    {
      'id': 2,
      'title': 'Seminar Cyber Security',
      'details': {
        'deskripsi': 'Seminar tentang keamanan siber di era digital.',
        'status': 'Sedang Berlangsung',
        'tanggal_mulai': '10-02-2024',
        'tanggal_selesai': '12-02-2024',
      },
    },
    {
      'id': 3,
      'title': 'Hackaton',
      'details': {
        'deskripsi': 'Kompetisi pengembangan aplikasi selama 48 jam.',
        'status': 'Sedang Berlangsung',
        'tanggal_mulai': '18-03-2024',
        'tanggal_selesai': '20-03-2024',
      },
    },
  ];

  // Variabel untuk data yang difilter
  List<Map<String, dynamic>> filteredProgressList = [];

  @override
  void initState() {
    super.initState();
    // Awalnya data yang difilter sama dengan data statis
    filteredProgressList = progressList;
  }

  // Fungsi untuk memfilter berdasarkan pencarian
  void _filterProgress(String query) {
    setState(() {
      filteredProgressList = progressList
          .where((progress) =>
              progress['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('List Progress'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Widget untuk input pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterProgress,
              decoration: InputDecoration(
                hintText: 'Cari progress...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          // Daftar progress
          Expanded(
            child: filteredProgressList.isEmpty
                ? const Center(child: Text('Tidak ada data progress'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredProgressList.length,
                    itemBuilder: (context, index) {
                      final progress = filteredProgressList[index];
                      return ProgressItem(
                        title: progress['title'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailProgressPage(
                                progressDetails: progress['details'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan setiap item progress
class ProgressItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ProgressItem({
    super.key,
    required this.title,
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
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// Halaman Detail Progress
class DetailProgressPage extends StatelessWidget {
  final Map<String, dynamic> progressDetails;

  const DetailProgressPage({super.key, required this.progressDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Detail Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(progressDetails['deskripsi']),
            const SizedBox(height: 16),
            Text(
              'Status:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(progressDetails['status']),
            const SizedBox(height: 16),
            Text(
              'Tanggal Mulai:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(progressDetails['tanggal_mulai']),
            const SizedBox(height: 16),
            Text(
              'Tanggal Selesai:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(progressDetails['tanggal_selesai']),
          ],
        ),
      ),
    );
  }
}
