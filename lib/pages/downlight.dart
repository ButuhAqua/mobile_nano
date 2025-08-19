// lib/pages/downlight.dart
import 'package:flutter/material.dart';

import 'categories_piko.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class DownlightPikoPage extends StatelessWidget {
  const DownlightPikoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ==== THEME (meniru desain contoh A-Bulb) ====
    const Color bg = Color(0xFF061F3D);          // latar utama
    const Color cardDark = Color(0xFF12355C);    // kartu gelap utk gambar
    const Color headerLight = Color(0xFFE9ECEF); // header tabel terang
    const Color blue6500 = Color(0xFF1EA7FF);    // highlight 6500K
    const Color yellow3000 = Color(0xFFFFC107);  // highlight 3000K

    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;

    // ---- helpers ----
    Widget brandPill() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.black),
              SizedBox(width: 8),
              Text('Pikolite', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    Widget imageCard() => Container(
          decoration: BoxDecoration(color: cardDark, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(16),
          child: Image.asset(
            'assets/images/downlightpiko.jpg',
            height: isTablet ? 220 : 190,
            fit: BoxFit.contain,
          ),
        );

    Widget specCard() {
      Text _row(String l, String r) => Text.rich(TextSpan(children: [
            TextSpan(text: '$l: ', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
            TextSpan(text: r, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ]));

      return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              child: Text('SPESIFIKASI',
                  style: TextStyle(color: Colors.blueGrey.shade800, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 10),
            _row('Tahan Sampai', '15.000 Jam'),
            const SizedBox(height: 6),
            _row('Voltase', '165v–250v (50/60Hz)'),
            const SizedBox(height: 6),
            _row('Fluks Cahaya', '600Lm'),
            const SizedBox(height: 6),
            _row('Hemat Energi', '90%'),
            const SizedBox(height: 6),
            _row('CRI', '>85'),
          ],
        ),
      );
    }

    // table cell helpers
    Widget th(String t) => Container(
          color: headerLight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Center(child: Text(t, style: const TextStyle(fontWeight: FontWeight.w700))),
        );
    Widget td(String t) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Center(child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
        );
    Widget tdBlue(String t) => Container(
          color: blue6500,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Center(child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
        );
    Widget tdYellow(String t) => Container(
          color: yellow3000,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: const Center(child: Text('3000K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800))),
        );

    Widget specTable() {
      // Menyerupai struktur tabel A-Bulb: Watt | Tinggi | Diameter | Warm White | Cool Day Light | Harga
      final rows = [
        ['6 Watt',  '108mm', '25mm', '3000K', '6500K', 'Rp 23.900'],
        ['9 Watt',  '125mm', '25mm', '3000K', '6500K', 'Rp 30.900'],
        ['12 Watt', '150mm', '25mm', '3000K', '6500K', 'Rp 40.900'],
        ['18 Watt', '175mm', '25mm', '3000K', '6500K', 'Rp 49.900'],
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: isTablet
            ? {
                0: const FlexColumnWidth(1.1),
                1: const FlexColumnWidth(1.2),
                2: const FlexColumnWidth(1.2),
                3: const FlexColumnWidth(1.6),
                4: const FlexColumnWidth(1.6),
                5: const FlexColumnWidth(1.4),
              }
            : const {
                0: FixedColumnWidth(110),
                1: FixedColumnWidth(110),
                2: FixedColumnWidth(120),
                3: FixedColumnWidth(130),
                4: FixedColumnWidth(130),
                5: FixedColumnWidth(120),
              },
        children: [
          TableRow(children: [
            th('Watt'),
            th('Tinggi'),
            th('Diameter'),
            th('Warm White'),
            th('Cool Day Light'),
            th('Harga'),
          ]),
          for (final r in rows)
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFF0C2B49)),
              children: [
                td(r[0]),
                td(r[1]),
                td(r[2]),
                tdYellow(r[3]),
                tdBlue(r[4]),
                td(r[5]),
              ],
            ),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: const Color(0xFF0F2D4B), borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(10),
        child: isTablet ? table : SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    Widget compareImage(String title, String path) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),
            Container(
              decoration: BoxDecoration(color: cardDark, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Image.asset(path, height: isTablet ? 200 : 170, fit: BoxFit.contain),
            ),
          ],
        );

    // ==== PAGE ====
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CategoriesPikoScreen()));
            }
          },
        ),
        title: const Text('nanopiko', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 16),
        children: [
          brandPill(),
          SizedBox(height: vPad),

          Text('Product Downlight',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
          SizedBox(height: vPad),

          // HERO: tablet berdampingan; smartphone stack (gambar center + lebih besar)
          LayoutBuilder(builder: (context, c) {
            final useRow = isTablet && c.maxWidth >= 680;

            if (useRow) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: imageCard()),
                  const SizedBox(width: 16),
                  Expanded(child: specCard()),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: imageCard()),
                const SizedBox(height: 12),
                specCard(),
              ],
            );
          }),

          SizedBox(height: vPad * 1.2),

          // TABLE (HP scroll horizontal)
          specTable(),

          SizedBox(height: vPad * 1.5),

          // PERBANDINGAN — tablet 2 kolom, smartphone 1 kolom (stack)
          LayoutBuilder(builder: (context, c) {
            final twoCols = isTablet && c.maxWidth >= 680;
            final left = compareImage('PIKOLITE', 'assets/images/downpiko.jpg');
            final right = compareImage('PRODUK LAIN', 'assets/images/downkom.jpg');

            if (twoCols) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: left),
                  const SizedBox(width: 16),
                  Expanded(child: right),
                ],
              );
            }
            return Column(children: [left, const SizedBox(height: 12), right]);
          }),
        ],
      ),

      // bottom navigation (kapsul)
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home, 'Home', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              }),
              _navItem(Icons.shopping_cart, 'Create Order', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CreateSalesOrderScreen()));
              }),
              _navItem(Icons.person, 'Profile', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable bottom item
Widget _navItem(IconData icon, String label, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black87),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black87, fontSize: 12)),
      ],
    ),
  );
}
