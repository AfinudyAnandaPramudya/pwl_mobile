import 'package:flutter/material.dart';

class JenisKegiatan extends StatelessWidget {
  const JenisKegiatan({super.key, required int kegiatanId});

  @override
  Widget build(BuildContext context) {
    // Static data for the table (only showing jenis kegiatan)
    final List<Map<String, dynamic>> data = [
      {
        "id": 1,
        "jenis": "Non-JTI",
      },
      {
        "id": 2,
        "jenis": "Terprogram",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Jenis Kegiatan'),
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
                  'Jenis Kegiatan',
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
                        DataCell(Text(item['jenis'])),
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
