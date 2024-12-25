import 'package:flutter/material.dart';
import 'package:pwl_mobile/Pimpinan/statistik.dart';
import 'progress_kegiatan.dart';
import 'kelola_kegiatan.dart'; // Import for "Kelola Kegiatan Non JTI"
import 'package:pwl_mobile/Pimpinan/agenda_kegiatan.dart'; // Import for "Agenda Kegiatan"

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  // Data statis
  final int _jumlahprogress = 3;
  final int _jumlahkegiatan = 3;
  final int _jumlahagenda = 3; // Static data for Agenda Kegiatan
  final int _jumlahkelolaKegiatanNonJTI =
      3; // Static data for Kelola Kegiatan Non JTI

  // Data dinamis untuk header
  String? _nama;
  bool _isLoadingHeader = true;

  @override
  void initState() {
    super.initState();
    _loadHeaderData();
  }

  // Simulasi fungsi untuk memuat nama dinamis
  Future<void> _loadHeaderData() async {
    setState(() => _isLoadingHeader = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulasi fetch data
    setState(() {
      _nama = "Nopal"; // Data dinamis dari API
      _isLoadingHeader = false;
    });
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
                    _isLoadingHeader ? 'Memuat...' : 'Halo, $_nama',
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
      ),
      backgroundColor: const Color(0xFF1F4C97),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
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
          _buildCategorySection(context),
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
                'Kelola Kegiatan Non JTI',
                Icons.calendar_today_outlined,
                _jumlahkelolaKegiatanNonJTI,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KelolaKegiatan(
                      kegiatanId: 9,
                    ), // Page for Kelola Kegiatan Non JTI
                  ),
                ),
              ),
              _buildCategoryCard(
                context,
                'Progress Kegiatan',
                Icons.precision_manufacturing_outlined,
                _jumlahprogress,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProgressKegiatan(
                      kegiatanId: 9,
                    ),
                  ),
                ),
              ),
              _buildCategoryCard(
                context,
                'Agenda Kegiatan',
                Icons.precision_manufacturing_outlined,
                _jumlahprogress,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgendaKegiatanPage(
                      kegiatanId: 9,
                      progressDetails: 9,
                    ),
                  ),
                ),
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
        width: MediaQuery.of(context).size.width *
            0.28, // Adjust width for 3 cards
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
}
