import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pwl_mobile/Dosen/progress_kegiatan.dart';
import 'agenda_kegiatan.dart';
import '../auth_service.dart';
import 'list_kegiatan.dart';
class PenggunaPage extends StatefulWidget {
  const PenggunaPage({super.key, required int kegiatanId});

  @override
  State<PenggunaPage> createState() => _PenggunaPageState();
}

class _PenggunaPageState extends State<PenggunaPage> {
  final Dio _dio = Dio();
  final AuthService _authService = AuthService();

  final String baseUrl = 'http://127.0.0.1:8000/api';
  final String _kegiatanUrl = 'http://127.0.0.1:8000/kegiatan';

  String? _nama;
  int _jumlahKegiatan = 0;
  bool _isLoading = true;
  bool _isLoadingKegiatan = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _fetchData();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => _isLoading = true);

      final token = await _authService.getToken();
      if (token == null) throw Exception('Token not found');

      final response = await _dio.get(
        '$baseUrl/user',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final userData = response.data['user'];
        setState(() {
          _nama = userData['nama'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data pengguna')),
      );
    }
  }

  Future<void> _fetchData() async {
    setState(() {
            _isLoadingKegiatan = true;
    });
    await Future.wait([
      _fetchJumlahKegiatan(),
    ]);
  }

  Future<void> _fetchJumlahKegiatan() async {
    try {
      final response = await _dio.get(_kegiatanUrl);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        setState(() {
          _jumlahKegiatan = data.length;
          _isLoadingKegiatan = false;
        });
      } else {
        throw Exception('Gagal memuat data Kegiatan');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoadingKegiatan = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFD3D3D3),
              child: Icon(Icons.person, color: Color(0xFF1F4C97), size: 30),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isLoading ? 'Memuat...' : 'Halo, $_nama',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Selamat datang di Sistem SDM',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
            tooltip: 'Perbarui Data',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1F4C97),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader()
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildCard(context),
          Expanded(
            child: _buildCategorySection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 130,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F4C97), Color(0xFF1F4C97)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildTitle(),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFEDF6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Pengguna',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF494949),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    '0',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF494949),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _navigateToAgendaKegiatan(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Lihat',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.withOpacity(0.6),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(right: 20.0),
              child: const SizedBox(
                height: 100,
                width: 100,
                child: Image(
                  image: AssetImage('asset/List.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
            'Sistem SDM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Politeknik Negeri Malang',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Kategori',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryCard(
                context,
                'Kelola Pengguna\n',
                Icons.school,
                _jumlahKegiatan,
                () => _navigateToListKegiatan(context),
              ),
              _buildCategoryCard(
                context,
                'Level Pengguna\n',
                Icons.school,
                _jumlahKegiatan,
                () => _navigateToAgendaKegiatan(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    IconData icon,
    int count,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
          color: const Color(0xFFEDF6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF1F4C97),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F4C97),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAgendaKegiatan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgendaKegiatanPage(kegiatanId: 0,)),
    );
  }

  void _navigateToProgress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProgressPage(kegiatanId: 0,)),
    );
  }

  void _navigateToListKegiatan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ListKegiatanPage(kegiatanId: 0,)),
    );
  }
}
