import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../auth_service.dart';
import 'edit_profile.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Dio _dio = Dio();
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final AuthService _authService = AuthService();

  String? _nama;
  String? _email;
  String? _username;
  String? _nip;
  String? _avatar;
  bool _isLoading = true;
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => _isLoading = true);

      final token = await _authService.getToken();
      print('Debug - Token: $token');

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

      print('Debug - Response: ${response.data}');

      if (response.statusCode == 200 && response.data['success']) {
        final userData = response.data['user'];
        setState(() {
          _userData = userData;
          _nama = userData['nama'];
          _email = userData['email'];
          _username = userData['username'];
          _nip = userData['nip'];
          _avatar = userData['avatar'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Debug - Error: $e');
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data profil')),
      );
    }
  }

  Future<void> _logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman login Anda
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4C97),
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadUserProfile,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: _avatar != null && _avatar!.isNotEmpty
                            ? ClipOval(
                                child: Image.network(
                                  'http://127.0.0.1:8000/storage/avatars/$_avatar',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _nama ?? 'Tidak ada data',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildProfileField(
                        "Email",
                        _email ?? 'Tidak ada data',
                        Icons.email,
                      ),
                      SizedBox(height: 20),
                      _buildProfileField(
                        "Nama Pengguna",
                        _username ?? 'Tidak ada data',
                        null,
                      ),
                      SizedBox(height: 20),
                      _buildProfileField(
                        "NIP",
                        _nip ?? 'Tidak ada data',
                        null,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(
                                    userData: {
                                      'nama': _nama,
                                      'email': _email,
                                      'username': _username,
                                      'nip': _nip,
                                      'avatar': _avatar,
                                    },
                                  ),
                                ),
                              ).then((value) {
                                if (value == true) {
                                  _loadUserProfile();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1F4C97),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

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
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
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
                Icon(icon, color: Colors.black54),
              ]
            ],
          ),
        ),
      ],
    );
  }
}