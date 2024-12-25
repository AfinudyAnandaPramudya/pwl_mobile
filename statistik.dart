import 'package:flutter/material.dart';

class Statistik extends StatelessWidget {
  const Statistik({super.key, required int kegiatanId});

  @override
  Widget build(BuildContext context) {
    // Static data for the table
    final List<Map<String, dynamic>> data = [
      {
        "nomor": 1,
        "nama": "Yola",
        "nip": "22764683764738",
        "total_poin": 3,
      },
      {
        "nomor": 2,
        "nama": "Liya",
        "nip": "22764683764738",
        "total_poin": 2,
      },
      {
        "nomor": 3,
        "nama": "Nopal",
        "nip": "22764683764738",
        "total_poin": 5,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Statistik'),
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
                  'Nama',
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
              DataColumn(
                label: Text(
                  'Total Poin',
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
                        DataCell(Text(item['nomor'].toString())),
                        DataCell(Text(item['nama'])),
                        DataCell(Text(item['nip'])),
                        DataCell(Text(item['total_poin'].toString())),
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
