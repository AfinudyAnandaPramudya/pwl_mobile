import 'package:flutter/material.dart';
// Pastikan EditProfileScreen sudah diimpor atau dibuat
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Latar belakang putih full untuk seluruh layar
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4C97), // Warna biru untuk AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Panah kembali warna putih
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.white), // Tulisan header warna putih
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circle Avatar untuk Foto Profile
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // Nama Dosen dan NIP
              Text(
                "NAMA DOSEN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "198XXXXXXXXXXXXXX",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 30),
              // Field Email
              _buildProfileField(
                  "Email", "dosen@universitas.ac.id", Icons.email),
              SizedBox(height: 20),
              // Field Nama Pengguna
              _buildProfileField("Nama Pengguna", "username", null),
              SizedBox(height: 30),
              // Tombol Edit
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfilePage(), // Pastikan EditProfileScreen ada
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F4C97),
                  ),
                  child: Text(
                    "EDIT",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun field profile dengan label dan value
  Widget _buildProfileField(String label, String value, IconData? icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background field warna abu-abu
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity, // Agar box mengambil lebar penuh
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              if (icon != null) ...[
                SizedBox(width: 10),
                Icon(icon, color: Colors.black54), // Ikon untuk email
              ]
            ],
          ),
        ),
      ],
    );
  }
}
