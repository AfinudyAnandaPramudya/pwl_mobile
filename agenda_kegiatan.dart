import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AgendaKegiatanPage extends StatefulWidget {
  final int kegiatanId;

  const AgendaKegiatanPage({super.key, required this.kegiatanId, required progressDetails});

  @override
  State<AgendaKegiatanPage> createState() => _AgendaKegiatanPageState();
}

class _AgendaKegiatanPageState extends State<AgendaKegiatanPage> {
  final Dio _dio = Dio();
  final String baseUrl = 'http://127.0.0.1:8000/api';
  Map<String, dynamic>? _kegiatanData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKegiatanDetail();
  }

  Future<void> _fetchKegiatanDetail() async {
    try {
      final response = await _dio.get('$baseUrl/kegiatan/${widget.kegiatanId}');

      setState(() {
        _kegiatanData = response.data['data'];
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
        title: const Text('Detail Agenda Kegiatan'),
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBE8FD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _kegiatanData!['jenis']?['jenis_nama'] ??
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
                          _kegiatanData!['nama_kegiatan'] ?? 'Tidak ada nama',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        _buildInfoRow('Level Kegiatan : ',
                            _kegiatanData!['kegiatan_id'] ?? 'Tidak ada id'),
                        /*_buildInfoRow(
                            'Tanggal Mulai : ',
                            _kegiatanData!['tanggal_mulai']?.int() ??
                                'Tidak ada tanggal'),
                        _buildInfoRow(
                            'Tanggal Selesai',
                            _kegiatanData!['tanggal_selesai'].int() ??
                                'Tidak ada tanggal'),*/
                        _buildInfoRow(
                            'Tempat',
                            _kegiatanData!['tempat']?.toString() ??
                                'Tidak ada kuota'),
                        _buildInfoRow(
                            'status',
                            _kegiatanData!['status']?.toString() ??
                                'Tidak ada biaya'),
                        const SizedBox(height: 30),
                        const Text(
                          'Deskripsi Kegiatan',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _kegiatanData!['deskripsi_kegiatan'] ??
                              'Tidak ada deskripsi',
                          style: TextStyle(color: Colors.grey[600]),
                          textAlign: TextAlign.justify,
                        ),
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
