import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import '../auth_service.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final Dio _dio = Dio();
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _namaController;
  late TextEditingController _nipController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _avatar;
  bool _isLoading = false;
  File? _imageFile;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.userData['email']);
    _usernameController =
        TextEditingController(text: widget.userData['username']);
    _namaController = TextEditingController(text: widget.userData['nama']);
    _nipController = TextEditingController(text: widget.userData['nip']);
    _avatar = widget.userData['avatar'];
    print('Current avatar: $_avatar'); // Debug print
  }

  Future<void> _pickImage() async {
    try {
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Pilih Sumber Gambar'),
          actions: <Widget>[
            TextButton(
              child: Text('Kamera'),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            TextButton(
              child: Text('Galeri'),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 75,
        );

        if (image != null) {
          setState(() {
            _imageFile = File(image.path);
          });
          print('Image selected: ${image.path}');
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih gambar: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1F4C97),
        title: Text(
          'Edit Profil',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : (_avatar != null && _avatar!.isNotEmpty
                                ? NetworkImage(
                                        'http://127.0.0.1:8000/storage/avatars/$_avatar')
                                    as ImageProvider
                                : null),
                        child: (_imageFile == null &&
                                (_avatar == null || _avatar!.isEmpty))
                            ? Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1F4C97),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileField('Email', _emailController),
                SizedBox(height: 20),
                _buildProfileField('Nama Lengkap', _namaController),
                SizedBox(height: 20),
                _buildProfileField('Nama Pengguna', _usernameController),
                SizedBox(height: 20),
                _buildProfileField('NIP', _nipController),
                SizedBox(height: 20),
                // Password field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Password Baru',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF1F4C97),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          hintText:
                              'Kosongkan jika tidak ingin mengubah password',
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Konfirmasi Password field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Konfirmasi Password Baru',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF1F4C97),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          hintText: 'Masukkan ulang password baru',
                        ),
                        validator: (value) {
                          if (_passwordController.text.isNotEmpty) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi password harus diisi';
                            }
                            if (value != _passwordController.text) {
                              return 'Password tidak sama';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_passwordController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Password minimal 6 karakter',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child:
                          Text('Batal', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          : Text('Simpan',
                              style: TextStyle(color: Colors.white)),
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

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field ini tidak boleh kosong';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password dan konfirmasi password harus sama'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception('Token not found');

      print('Updating profile with values:');
      print('Email: ${_emailController.text}');
      print('Username: ${_usernameController.text}');
      print('Nama: ${_namaController.text}');
      print('NIP: ${_nipController.text}');
      print('Password changed: ${_passwordController.text.isNotEmpty}');

      final Map<String, dynamic> formFields = {
        'email': _emailController.text.trim(),
        'username': _usernameController.text.trim(),
        'nama': _namaController.text.trim(),
        'nip': _nipController.text.trim(),
      };

      if (_passwordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text) {
        formFields['password'] = _passwordController.text;
      }

      final formData = FormData.fromMap(formFields);

      if (_imageFile != null) {
        print('Adding image file: ${_imageFile!.path}');
        try {
          String fileName = _imageFile!.path.split('/').last;
          formData.files.add(
            MapEntry(
              'avatar',
              await MultipartFile.fromFile(
                _imageFile!.path,
                filename: fileName,
                contentType: MediaType('image', fileName.split('.').last),
              ),
            ),
          );
          print('Image added to form data: $fileName');
        } catch (e) {
          print('Error adding image to form data: $e');
        }
      }

      print('Sending request to: http://127.0.0.1:8000/api/user/update');
      final response = await _dio.post(
        'http://127.0.0.1:8000/api/user/update',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
          followRedirects: false,
          validateStatus: (status) {
            print('Response status code: $status');
            return true;
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        // Update local avatar state with new filename
        if (response.data['data'] != null &&
            response.data['data']['avatar'] != null) {
          setState(() {
            _avatar = response.data['data']['avatar'];
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profil berhasil diperbarui'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        throw Exception(response.data['message'] ?? 'Gagal memperbarui profil');
      }
    } catch (e) {
      print('Error detail: $e');
      if (e is DioException) {
        print('DioError type: ${e.type}');
        print('DioError message: ${e.message}');
        print('DioError response: ${e.response?.data}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memperbarui profil: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _namaController.dispose();
    _nipController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}