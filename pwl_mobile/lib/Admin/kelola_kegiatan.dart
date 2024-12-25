import 'package:flutter/material.dart';

class KelolaKegiatan extends StatelessWidget {
  const KelolaKegiatan({super.key, required int kegiatanId});

  @override
  Widget build(BuildContext context) {
    // Static data for the table
    final List<Map<String, dynamic>> data = [
      {
        "id": 1,
        "nama": "Porseni",
        "jenis": "Terprogram",
        "tanggal_mulai": "22-04-2022",
        "tanggal_selesai": "28-04-2022",
        "bobot": "Ringan",
        "status": "Belum Dimulai",
      },
      {
        "id": 2,
        "nama": "Panitia Skripsi",
        "jenis": "Terprogram",
        "tanggal_mulai": "19-08-2022",
        "tanggal_selesai": "27-08-2022",
        "bobot": "Ringan",
        "status": "Belum Dimulai",
      },
      {
        "id": 1,
        "nama": "Rapat",
        "jenis": "Non-JTI",
        "tanggal_mulai": "21-03-2022",
        "tanggal_selesai": "22-04-2022",
        "bobot": "Ringan",
        "status": "Selesai",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Progress Kegiatan'),
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
                  'Jenis',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal Mulai',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal Selesai',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Bobot Kerja',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
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
                        DataCell(Text(item['nama'])),
                        DataCell(Text(item['jenis'])),
                        DataCell(Text(item['tanggal_mulai'])),
                        DataCell(Text(item['tanggal_selesai'])),
                        DataCell(Text(item['bobot'])),
                        DataCell(Text(item['status'])),
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
