import 'package:flutter/material.dart';

class KelolaAnggotaKegiatan extends StatelessWidget {
  const KelolaAnggotaKegiatan({super.key, required int kegiatanId});

  @override
  Widget build(BuildContext context) {
    // Updated static data to include namaAnggota, jabatan, kegiatan, and poin
    final List<Map<String, dynamic>> data = [
      {
        "namaAnggota": "Nopal",
        "jabatan": "PIC",
        "kegiatan": "Porseni",
        "poin": 1,
      },
      {
        "namaAnggota": "Haykal",
        "jabatan": "Anggota",
        "kegiatan": "Porseni",
        "poin": 0.5,
      },
      {
        "namaAnggota": "Nina",
        "jabatan": "Sekretaris",
        "kegiatan": "Porseni",
        "poin": 0.5,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F4C97),
        foregroundColor: Colors.white,
        title: const Text('Kelola Anggota'),
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
                  'Nama Anggota',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Jabatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Kegiatan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1F4C97),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Poin',
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
                        DataCell(Text(item['namaAnggota'])),
                        DataCell(Text(item['jabatan'])),
                        DataCell(Text(item['kegiatan'])),
                        DataCell(Text(item['poin'].toString())),
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
