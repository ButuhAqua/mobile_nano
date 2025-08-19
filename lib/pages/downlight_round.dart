// lib/pages/downlight_round.dart
import 'package:flutter/material.dart';

import 'categories_nano.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class DownlightRoundPage extends StatelessWidget {
  const DownlightRoundPage({super.key});

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
    const Color yellow3000 = Color(0xFFFFC107);
    const Color gray4000 = Color(0xFFBDBDBD);

    // ---- RESPONSIVE ----
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;
    final double productCardH = isTablet ? 300 : 220;

    // ---- HELPERS UI ----
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

    Widget bullet(String text, {bool bold = false}) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 6, color: Colors.white)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text,
                  style: TextStyle(color: textPrimary, fontWeight: bold ? FontWeight.w800 : FontWeight.w600)),
            ),
          ],
        );

    Widget productImage(String path) => Container(
          height: productCardH,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(path, fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.broken_image, color: Colors.white70, size: 48),
                    )),
          ),
        );

    // ✅ Spesifikasi tanpa baris Harga
    Widget productSpec({double? height}) => Container(
          height: height,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: specPill()),
              SizedBox(height: isTablet ? 16 : 12),
              bullet('Tahan Sampai: 25.000 Jam', bold: true),
              const SizedBox(height: 8),
              bullet('Slim desain (H): 26mm'),
              const SizedBox(height: 8),
              bullet('Hemat Energi: 90%'),
              const SizedBox(height: 8),
              bullet('CRI: >80'),
              const SizedBox(height: 8),
              bullet('IP: 20'),
              const SizedBox(height: 8),
              bullet('Beam Angle: 120°'),
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ---------- TABLE ----------
    Widget th(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: headerDark,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget tdText(String text, {TextAlign align = TextAlign.center, bool bold = false}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          child: Text(text,
              textAlign: align,
              style: TextStyle(
                  color: Colors.white, fontWeight: bold ? FontWeight.w700 : FontWeight.w600, fontSize: 12)),
        );

    Widget tdColor(String text, Color bg, {bool darkText = false}) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          color: bg,
          child: Text(text,
              style: TextStyle(
                  color: darkText ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12)),
        );

    Widget specTable() {
      final rows = [
        ['5 Watt', '600lm', '95mm', '100', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['9 Watt', '1080lm', '118mm', '100', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['12 Watt', '1440lm', '145mm', '60', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['15 Watt', '1800lm', '170mm', '60', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['18 Watt', '2160lm', '220mm', '40', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(100),
          1: FixedColumnWidth(90),
          2: FixedColumnWidth(90),
          3: FixedColumnWidth(70),
          4: FixedColumnWidth(80),
          5: FixedColumnWidth(160),
          6: FixedColumnWidth(80),
          7: FixedColumnWidth(140),
          8: FixedColumnWidth(80),
          9: FixedColumnWidth(180),
        },
        children: [
          TableRow(children: [
            th('Varian Watt'),
            th('Lumen'),
            th('Diameter'),
            th('Isi/Dus'),
            th('Warna'),
            th('Keterangan'),
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
              tdText(r[3]),
              tdColor(r[4], blue6500),
              tdText(r[5]),
              tdColor(r[6], gray4000, darkText: true),
              tdText(r[7]),
              tdColor(r[8], yellow3000),
              tdText(r[9]),
            ]),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    // ===== Hanya gambar perbandingan =====
    Widget comparisonImages() => LayoutBuilder(
          builder: (context, c) {
            final row = isTablet && c.maxWidth >= 680;
            final img1 = productImage('assets/images/dsquarecom.jpg');
            final img2 = productImage('assets/images/drsquarenano.jpg');
            if (row) {
              return Row(children: [
                Expanded(child: img1),
                const SizedBox(width: 12),
                Expanded(child: img2),
              ]);
            }
            return Column(children: [img1, SizedBox(height: vPad), img2]);
          },
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
            Text('Product Downlight Round',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),

            // Gambar + spesifikasi
            LayoutBuilder(builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;
              final img = productImage('assets/images/downlsquare.jpg');
              final spec = productSpec(height: row ? productCardH : null);
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
            specTable(),

            SizedBox(height: vPad * 1.5),
            Text('Perbandingan:',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 16 : 15)),
            SizedBox(height: vPad),
            comparisonImages(),
          ],
        ),
      ),

      // Bottom bar
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

// ---------- NAV ITEM ----------
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
