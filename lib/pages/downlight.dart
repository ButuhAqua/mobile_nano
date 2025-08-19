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
    // ---- THEME ----
    const Color bgTop = Color(0xFF0B2741);
    const Color bgBottom = Color(0xFF0E3556);
    const Color card = Color(0xFF0F2D4B);
    const Color chip = Color(0xFF163E66);
    const Color textPrimary = Colors.white;

    // Table colors
    const Color headerDark = Color(0xFF0B2741);
    const Color blue6500 = Color(0xFF03A9F4);
    const Color yellow3000 = Color(0xFFFFC107);

    // ---- RESPONSIVE ----
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;
    final double heroH = isTablet ? 360 : 240;
    final double? compH = isTablet ? 280 : null;

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
          child: const Text('Spesifikasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800)),
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

    // Spesifikasi HANYA untuk hero (sesuai gambar 1)
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
              bullet('Voltase', '165v–250v (50/60Hz)'),
              bullet('Fluks Cahaya', '600Lm'),
              bullet('Hemat Energi', '90%'),
              bullet('CRI', '>85'),
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ------- TABLE (sesuai gambar 2) -------
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

    Widget tdColor(String text, Color bg, {bool darkText = false}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          color: bg,
          child: Text(text,
              style: TextStyle(
                color: darkText ? Colors.black : Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              )),
        );

    Widget specTable() {
      final rows = [
        ['6 Watt', '108mm x 25mm', 'Rp 23.900', '6500K', 'Cahaya Putih Kebiruan', '3000K', 'Cahaya Putih Kekuningan'],
        ['9 Watt', '125mm x 25mm', 'Rp 30.900', '6500K', 'Cahaya Putih Kebiruan', '3000K', 'Cahaya Putih Kekuningan'],
        ['12 Watt', '150mm x 25mm', 'Rp 40.900', '6500K', 'Cahaya Putih Kebiruan', '3000K', 'Cahaya Putih Kekuningan'],
        ['18 Watt', '175mm x 25mm', 'Rp 49.900', '6500K', 'Cahaya Putih Kebiruan', '3000K', 'Cahaya Putih Kekuningan'],
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(110), // Varian Watt
          1: FixedColumnWidth(200), // Dimensi Produk
          2: FixedColumnWidth(120), // Harga
          3: FixedColumnWidth(90),  // Warna 6500K
          4: FixedColumnWidth(220), // Keterangan 6500K
          5: FixedColumnWidth(90),  // Warna 3000K
          6: FixedColumnWidth(220), // Keterangan 3000K
        },
        children: [
          TableRow(children: [
            th('Varian Watt'),
            th('Dimensi Produk'),
            th('Harga'),
            th('Warna'),
            th('Keterangan'),
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
              tdColor(r[5], yellow3000, darkText: true),
              tdText(r[6]),
            ]),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    // ------- COMPARISON (gambar saja; 2 kolom tablet, 1 kolom mobile) -------
    Widget compareCard(String title, String imgPath) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w800, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),
            productImage(imgPath, height: compH),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CategoriesPikoScreen()));
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

            Text('Product Downlight',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),

            // HERO (gambar + spesifikasi)
            LayoutBuilder(builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;
              final img = productImage('assets/images/downlightpiko.jpg', height: row ? heroH : null);
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

            // TABLE di tengah
            specTable(),

            SizedBox(height: vPad * 1.5),

            // COMPARISON
            LayoutBuilder(builder: (context, c) {
              final twoCols = isTablet && c.maxWidth >= 680;
              if (twoCols) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: compareCard('PIKOLITE', 'assets/images/downpiko.jpg')),
                    const SizedBox(width: 16),
                    Expanded(child: compareCard('PRODUK LAIN', 'assets/images/downkom.jpg')),
                  ],
                );
              }
              return Column(
                children: [
                  compareCard('PIKOLITE', 'assets/images/downpiko.jpg'),
                  SizedBox(height: vPad * 1.5),
                  compareCard('PRODUK LAIN', 'assets/images/downkom.jpg'),
                ],
              );
            }),
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
