import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DetailProgressPage extends StatefulWidget {
  final int progressId;

  const DetailProgressPage({super.key, required this.progressId, required String title});

  @override
  State<DetailProgressPage> createState() => _DetailProgressPageState();
}

class _DetailProgressPageState extends State<DetailProgressPage> {
  final Dio _dio = Dio();
  final String baseUrl = 'http://127.0.0.1:8000/api';
  Map<String, dynamic>? _kegiatanData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProgressDetail();
  }

  Future<void> _fetchProgressDetail() async {
    try {
      final response =
          await _dio.get('$baseUrl/kegiatan/${widget.progressId}');

      setState(() {
        _kegiatanData =response.data['data']; // Pastikan mengakses data dari respons
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error
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
        title: const Text('Detail Progress'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _kegiatanData == null
              ? const Center(child: Text('Data tidak ditemukan'))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        // Bidang (Web Developer)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBE8FD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _kegiatanData!['jenis_kegiatan']?['nama_jenis_kegiatan'] ??
                                'Tidak ada jenis',
                            style: const TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _kegiatanData!['nama_kegiatan'] ??
                              'Tidak ada nama',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        // Tanggal
                        _buildInfoRow('Bobot',
                            _kegiatanData!['bobot_kerja'] ?? 'Tidak ada bobot'),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
