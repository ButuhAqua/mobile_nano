// lib/pages/multipiko.dart
import 'package:flutter/material.dart';

import 'categories_piko.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class MultipackPikoPage extends StatelessWidget {
  const MultipackPikoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ---- THEME ----
    const Color bgTop = Color(0xFF0B2741);
    const Color bgBottom = Color(0xFF0E3556);
    const Color card = Color(0xFF0F2D4B);
    const Color chip = Color(0xFF163E66);
    const Color textPrimary = Colors.white;

    // Table colors
    const Color headerDark = Color(0xFF0B2741);
    const Color blue6500 = Color(0xFF03A9F4);

    // ---- RESPONSIVE ----
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;
    final double heroH = isTablet ? 360 : 240;

    // ---- HELPERS ----
    Widget brandChip() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: chip, borderRadius: BorderRadius.circular(32)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Pikolite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    Widget specPill() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
          child:
              const Text('Spesifikasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800)),
        );

    Widget bullet(String title, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 14),
              children: [
                const TextSpan(text: '• ', style: TextStyle(fontWeight: FontWeight.w800)),
                TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w800)),
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
    Widget specCard({double? height}) => Container(
          height: height,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: specPill()),
              SizedBox(height: isTablet ? 16 : 12),
              bullet('Tahan Sampai', '15.000 Jam'),
              bullet('Fitting', 'E27'),
              bullet('Hemat Energi', '90%'),
              bullet('Lumen', '100Lm/watt'),
              bullet('Tegangan', '110–240V'),
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ------- TABLE (sesuai gambar) -------
    Widget th(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: headerDark,
          alignment: Alignment.center,
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

    // sel warna dengan background biru penuh
    Widget tdColor(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          color: blue6500,
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget specTable() {
      // <-- DATA diganti sesuai gambar: 5W, 7W, 9W, 12W
      final rows = [
        ['5 Watt',  '55mm x 102mm', 'Rp. 45,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['7 Watt',  '59mm x 115mm', 'Rp. 51,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['9 Watt',  '59mm x 115mm', 'Rp. 59,900', '6500K', 'Cahaya Putih Kebiruan'],
        ['12 Watt', '64mm x 123mm', 'Rp. 68,900', '6500K', 'Cahaya Putih Kebiruan'],
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(120), // Varian Watt
          1: FixedColumnWidth(220), // Dimensi Produk
          2: FixedColumnWidth(140), // Harga
          3: FixedColumnWidth(90),  // Warna
          4: FixedColumnWidth(240), // Keterangan
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
              tdColor(r[3]),
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => CategoriesPikoScreen()));
            }
          },
        ),
        title: const Text('pikolite', style: TextStyle(color: Colors.black)),
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

            Text('Product Multipack',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),

            // HERO (gambar + spesifikasi)
            LayoutBuilder(builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;
              final img = productImage('assets/images/multipikko.jpg', height: row ? heroH : null);
              final spec = specCard(height: row ? heroH : null);

              if (row) {
                return Row(children: [
                  Expanded(child: img),
                  const SizedBox(width: 12),
                  Expanded(child: spec),
                ]);
              }
              return Column(children: [img, SizedBox(height: vPad), spec]);
            }),

            SizedBox(height: vPad * 1.2),

            // TABLE di bawah hero
            specTable(),
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
