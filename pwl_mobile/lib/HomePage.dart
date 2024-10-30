import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistem Informasi SDM POLINEMA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, Liya Novitasari', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Kategori', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryCard('Dashboard', 'Lihat Dashboard'),
                CategoryCard('Pengaturan', 'Lihat Pengaturan'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryCard('Administrasi', 'Lihat Administrasi'),
                CategoryCard('Statistik', 'Lihat Statistik'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget CategoryCard(String title, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontSize: 20)),
            SizedBox(height: 5),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}