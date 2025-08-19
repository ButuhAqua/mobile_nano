import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // background utama
    const Color bg = Color(0xFF0A1B2D);

    final isTablet = MediaQuery.of(context).size.width >= 600;
    final padding = isTablet ? 24.0 : 16.0;
    final imageH = isTablet ? 260.0 : 220.0;
    final titleSize = isTablet ? 22.0 : 16.0;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('nanopiko', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.black),
                  SizedBox(width: 8),
                  Text('Nanolite',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Product Emergency',
              style: TextStyle(
                fontSize: titleSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // ===== HERO (gambar + spesifikasi)
            LayoutBuilder(builder: (context, c) {
              final sideBySide = isTablet && c.maxWidth >= 680;

              final image = Container(
                decoration: BoxDecoration(
                  color: bg, // nyatu dengan background
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Image.asset(
                    'assets/images/emergency.jpg',
                    height: imageH,
                    fit: BoxFit.contain,
                  ),
                ),
              );

              final spec = _SpecCard(
                items: const [
                  ['Tahan Sampai', 'Hingga 4 Jam'],
                  ['Baterai', '2200mAh Lithium'],
                  ['Hemat Energi', '90%'],
                  ['Arus', 'AC/DC'],
                  ['Tegangan', '100–240V'],
                ],
              );

              if (sideBySide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: image),
                    const SizedBox(width: 16),
                    const Expanded(flex: 6, child: _SpecCard(
                      items: [
                        ['Tahan Sampai', 'Hingga 4 Jam'],
                        ['Baterai', '2200mAh Lithium'],
                        ['Hemat Energi', '90%'],
                        ['Arus', 'AC/DC'],
                        ['Tegangan', '100–240V'],
                      ],
                    )),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  const SizedBox(height: 12),
                  spec,
                ],
              );
            }),

            const SizedBox(height: 28),

            // ===== TABLE (rapi & seragam)
            const _EmergencyVariantTable(),

            const SizedBox(height: 28),

            // ===== PERBANDINGAN (gambar)
            Text(
              'Perbandingan:',
              style: TextStyle(
                fontSize: titleSize,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            LayoutBuilder(builder: (context, c) {
              final twoCols = isTablet && c.maxWidth >= 680;

              Widget item(String title, String path) => Column(
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(path, height: isTablet ? 220 : 180),
                      ),
                    ],
                  );

              if (twoCols) {
                return Row(
                  children: [
                    Expanded(child: item('NANOLITE', 'assets/images/emerspek.jpg')),
                    const SizedBox(width: 12),
                    Expanded(child: item('PRODUK LAIN', 'assets/images/emerkomp.jpg')),
                  ],
                );
              }
              return Column(
                children: [
                  item('NANOLITE', 'assets/images/emerspek.jpg'),
                  const SizedBox(height: 12),
                  item('PRODUK LAIN', 'assets/images/emerkomp.jpg'),
                ],
              );
            }),

            const SizedBox(height: 60),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 'Home', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            }),
            _navItem(Icons.shopping_cart, 'Create Order', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CreateSalesOrderScreen()));
            }),
            _navItem(Icons.person, 'Profile', onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}

/// ---------- Spec Card Putih (header kecil + isi) ----------
class _SpecCard extends StatelessWidget {
  final List<List<String>> items;
  const _SpecCard({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    Widget header = Container(
      width: double.infinity,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFFE9ECEF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Center(
        child: Text('SPESIFIKASI',
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
      ),
    );

    Widget row(String l, String r) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
              children: [
                TextSpan(text: '$l: ', style: const TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(text: r, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (final i in items) row(i[0], i[1])],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- Tabel Varian Emergency (rapi, rata, konsisten) ----------
class _EmergencyVariantTable extends StatelessWidget {
  const _EmergencyVariantTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Palet tabel
    const Color bg = Color(0xFF0A1B2D);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);

    // Data 6 kolom (HARUS konsisten)
    const rows = [
      ['10 Watt', 'AC 1000lm / DC 700lm', '70mm x 141mm', '80', '6500K', 'Cahaya Putih Kebiruan'],
      // Tambah baris lain di sini jika perlu
    ];

    // Lebar kolom dipatok agar tidak shifting (total ≈ 900px)
    const columnWidths = <int, TableColumnWidth>{
      0: FixedColumnWidth(120), // Varian Watt
      1: FixedColumnWidth(210), // Lumen
      2: FixedColumnWidth(180), // Dimensi
      3: FixedColumnWidth(80),  // Isi/Dus
      4: FixedColumnWidth(90),  // Warna
      5: FixedColumnWidth(220), // Keterangan
    };

    // Header/cell builder dgn tinggi seragam
    Widget th(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Container(
            color: headerLight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, height: 1.1),
            ),
          ),
        );

    Widget td(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            color: bg,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, height: 1.1),
            ),
          ),
        );

    Widget tdColor(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            color: blue6500,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, height: 1.1),
            ),
          ),
        );

    final table = Table(
      border: const TableBorder.symmetric(
        inside: BorderSide(color: Colors.white24, width: 1),
        outside: BorderSide(color: Colors.white24, width: 1),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        TableRow(children: [
          th('Varian Watt'),
          th('Lumen'),
          th('Dimensi (Tinggi x Diameter)'),
          th('Isi/Dus'),
          th('Warna'),
          th('Keterangan'),
        ]),
        for (final r in rows)
          TableRow(children: [
            td(r[0]),
            td(r[1]),
            td(r[2]),
            td(r[3]),
            tdColor(r[4]),
            td(r[5]),
          ]),
      ],
    );

    // Selalu bungkus scroll horizontal supaya aman di layar sempit
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 900), // jumlah FixedColumnWidth di atas
          child: table,
        ),
      ),
    );
  }
}
