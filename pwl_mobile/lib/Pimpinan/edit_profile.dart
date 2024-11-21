import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih full
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4C97),
        title: Text(
          "Edit Profil",
          style: TextStyle(color: Colors.white), // Tulisan header warna putih
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('asset/profile_placeholder.png'),
                      // Jika tidak ada gambar, gunakan icon default
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Aksi untuk mengganti foto profil
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Field Email
              _buildProfileField('Email', 'email@example.com'),
              SizedBox(height: 20),
              // Field Kata Sandi
              _buildPasswordField('Kata Sandi', 'Kata Sandi Baru'),
              SizedBox(height: 20),
              // Field Nama Pengguna
              _buildProfileField('Nama Pengguna', 'Nama Pengguna'),
              SizedBox(height: 20),
              // Field Nama Lengkap
              _buildProfileField('Nama', 'Nama Lengkap'),
              SizedBox(height: 20),
              // Field NIP
              _buildProfileField('NIP', '1234567890'),
              SizedBox(height: 30),
              // Tombol Batal dan Simpan
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Batal', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk menyimpan perubahan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child:
                        Text('Simpan', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun field dengan warna background abu-abu
  Widget _buildProfileField(String label, String initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background abu-abu
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none, // Menghilangkan border
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  // Fungsi untuk membangun field kata sandi
  Widget _buildPasswordField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background abu-abu
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none, // Menghilangkan border
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
