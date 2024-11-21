import 'package:flutter/material.dart';
import 'package:project/Pimpinan/detail__dosen.dart';

// Halaman List Dosen
class ListDosenPage extends StatefulWidget {
  const ListDosenPage({Key? key}) : super(key: key);

  @override
  _ListDosenPageState createState() => _ListDosenPageState();
}

class _ListDosenPageState extends State<ListDosenPage> {
  bool isTersediaSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('List Dosen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // List of Dosen
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailDosen()),
                    );
                  },
                ),
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    // Action when tapping a dosen item
                  },
                ),
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    // Action when tapping a dosen item
                  },
                ),
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    // Action when tapping a dosen item
                  },
                ),
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    // Action when tapping a dosen item
                  },
                ),
                DosenItem(
                  name: 'Dr.Eng. Rosa Andire Asmara, ST, MT.',
                  onTap: () {
                    // Action when tapping a dosen item
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan setiap item dosen
class DosenItem extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const DosenItem({
    Key? key,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
