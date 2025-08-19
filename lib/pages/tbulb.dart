// lib/pages/tbulb.dart
import 'package:flutter/material.dart';

import 'categories_nano.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class TBulbPage extends StatelessWidget {
  const TBulbPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ---- PALETTE ----
    const Color bgTop = Color(0xFF0B2741);
    const Color bgBottom = Color(0xFF0E3556);
    const Color card = Color(0xFF0F2D4B);
    const Color chip = Color(0xFF163E66);
    const Color pillLight = Color(0xFFE7EEF7);
    const Color pillText = Color(0xFF0F2D4B);
    const Color textPrimary = Colors.white;

    // Table accents
    const Color headerDark = Color(0xFF0B2741);
    const Color blue6500 = Color(0xFF03A9F4);

    // ---- RESPONSIVE ----
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;
    final double heroH = isTablet ? 360 : 240;
    final double? compH = isTablet ? 300 : null;

    // ---- SMALL HELPERS ----
    Widget brandChip() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: chip, borderRadius: BorderRadius.circular(32)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Nanolite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    Widget specPill() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: pillLight, borderRadius: BorderRadius.circular(20)),
          child: const Text('SPESIFIKASI',
              style: TextStyle(color: pillText, fontWeight: FontWeight.w800, letterSpacing: .3)),
        );

    Widget bullet(String label, String value, {bool bold = false}) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white, height: 1.3),
              children: [
                TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: bold ? Colors.white : Colors.white70,
                    )),
                TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );

    Widget productImage(String path, {double? height}) => Container(
          height: height,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              path,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Center(child: Icon(Icons.broken_image, color: Colors.white70, size: 48)),
            ),
          ),
        );

    // Spesifikasi HANYA untuk hero
    Widget heroSpecCard({double? height}) => Container(
          height: height,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: specPill()),
              SizedBox(height: isTablet ? 16 : 12),
              // Pakai spesifikasi dari gambar "PIKOLITE"
              bullet('Tahan Sampai', '15.000 Jam', bold: true),
              bullet('Tegangan', '110v–240v'),
              bullet('Hemat Energi', '90%'),
              bullet('Fitting', 'E27'),
              bullet('CRI', '>80Ra'),
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ====== TABLE (sesuai gambar #2) ======
    Widget th(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          color: headerDark,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget tdText(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
        );

    Widget tdColor(String text, Color bg) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          color: bg,
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget specTable() {
      final rows = [
        ['5 Watt', '45mm x 100mm', 'Rp. 13,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['10 Watt', '59mm x 115mm', 'Rp. 20,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['15 Watt', '69mm x 133mm', 'Rp. 25,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['20 Watt', '80mm x 145mm', 'Rp. 32,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['30 Watt', '100mm x 180mm', 'Rp. 46,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['40 Watt', '113mm x 200mm', 'Rp. 65,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['50 Watt', '113mm x 215mm', 'Rp. 80,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['60 Watt', '113,4mm x 215mm', 'Rp. 93,900', '6500K', 'Cahaya Putih Kebiruan'],
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(110), // Varian Watt
          1: FixedColumnWidth(200), // Dimensi
          2: FixedColumnWidth(130), // Harga
          3: FixedColumnWidth(90),  // Warna
          4: FixedColumnWidth(220), // Keterangan
        },
        children: [
          TableRow(children: [
            th('Varian Watt'),
            th('Dimensi Produk'),
            th('Harga'),
            th('Warna'),
            th('Keterangan'),
          ]),
          for (final r in rows)
            TableRow(children: [
              tdText(r[0]),
              tdText(r[1]),
              tdText(r[2]),
              tdColor(r[3], blue6500),
              tdText(r[4]),
            ]),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    // Perbandingan: gambar saja
    Widget comparisonImageBlock({required String title, required String imagePath}) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w800, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),
            productImage(imagePath, height: compH),
          ],
        );

    // ---- PAGE ----
    return Scaffold(
      backgroundColor: bgBottom,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CategoriesNanoScreen()));
            }
          },
        ),
        title: const Text('nanopiko', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [bgTop, bgBottom]),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 16),
          children: [
            brandChip(),
            SizedBox(height: vPad),

            Text('Product T-Bulb',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),

            // HERO: gambar + spesifikasi
            LayoutBuilder(builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;
              final img = productImage('assets/images/tbulbpiko.jpg', height: row ? heroH : null);
              final spec = heroSpecCard(height: row ? heroH : null);

              if (row) {
                return Row(children: [
                  Expanded(child: img),
                  const SizedBox(width: 12),
                  Expanded(child: spec),
                ]);
              }
              return Column(children: [img, SizedBox(height: vPad), spec]);
            }),

            SizedBox(height: vPad),
            // TABEL di tengah (sebelum perbandingan)
            specTable(),

            SizedBox(height: vPad * 1.5),

            // PERBANDINGAN — tablet 2 kolom, mobile 1 kolom; NANOLITE di kiri
            if (isTablet) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: comparisonImageBlock(title: 'NANOLITE', imagePath: 'assets/images/tpiko.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: comparisonImageBlock(title: 'PRODUK LAIN', imagePath: 'assets/images/tkom.jpg'),
                  ),
                ],
              ),
            ] else ...[
              comparisonImageBlock(title: 'NANOLITE', imagePath: 'assets/images/tpiko.jpg'),
              SizedBox(height: vPad * 1.5),
              comparisonImageBlock(title: 'PRODUK LAIN', imagePath: 'assets/images/tkom.jpg'),
            ],
          ],
        ),
      ),

      // Bottom Navigation (kapsul)
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

// Bottom nav item
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
