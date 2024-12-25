import 'package:flutter/material.dart';

class KelolaPengguna extends StatelessWidget {
  const KelolaPengguna({super.key, required int kegiatanId});

  @override
  Widget build(BuildContext context) {
    // Static data for the table, now including 'id' as the first field
    final List<Map<String, dynamic>> data = [
      {
        "id": 1,
        "username": "Nopal",
        "level": "Dosen",
        "nip": "1234567890",
      },
      {
        "id": 2,
        "username": "Fidaa",
        "level": "Tim Perencana",
        "nip": "2345678901",
      },
      {
        "id": 3,
        "username": "Doni",
        "level": "Pimpinan",
        "nip": "3456789012",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Kelola Pengguna'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 56,
            columnSpacing: 20,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            columns: const [
              DataColumn(
                label: Text(
                  'ID',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'NIP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
            ],
            rows: data
                .asMap()
                .map(
                  (index, item) => MapEntry(
                    index,
                    DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (index.isEven) {
                            return Colors.blueGrey.shade50;
                          }
                          return Colors.white;
                        },
                      ),
                      cells: [
                        DataCell(Text(item['id'].toString())),
                        DataCell(Text(item['username'])),
                        DataCell(Text(item['level'])),
                        DataCell(Text(item['nip'])),
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }
}
