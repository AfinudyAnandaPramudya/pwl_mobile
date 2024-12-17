import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UploadScreen(
        onFileUploaded: (String fileName) {
          // Dummy callback, not used in main app
        },
      ),
    );
  }
}

class UploadScreen extends StatefulWidget {
  final Function(String) onFileUploaded; // Callback untuk mengembalikan nama file

  UploadScreen({required this.onFileUploaded}); // Constructor

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String _fileName = "Tidak ada file terpilih"; // Variabel untuk menyimpan nama file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF1F4C97),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Unggah File',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 50,
                        color: Color(0xFF1F4C97),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Unggah berkas '),
                            TextSpan(
                              text: 'di sini',
                              style: TextStyle(color: Color(0xFF1F4C97), fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _showFileDialog(context); // Tampilkan dialog berkas saat 'di sini' diklik
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _fileName, // Menampilkan status file yang terpilih
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F4C97),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
    );
  }

  void _showFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Berkas Contoh'),
          content: Text('Berkas contoh berhasil ditambahkan!'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _fileName = 'Berkas Contoh.txt'; // Simulasi berkas yang diunggah
                });
                widget.onFileUploaded(_fileName); // Mengembalikan nama file ke form
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
