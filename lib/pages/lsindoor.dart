// lib/pages/Isindoor.dart
import 'package:flutter/material.dart';

import 'categories_nano.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class IndoorPage extends StatelessWidget {
  const IndoorPage({super.key});

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

    // Tabel accents
    const Color headerDark = Colors.white; // header diubah putih
    const Color headerText = Colors.black; // teks header hitam
    const Color accentBlue = Color(0xFF03A9F4);   // 6500K
    const Color accentYellow = Color(0xFFFFC107); // 3000K

    // ---- RESPONSIVE ----
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;
    final double heroH = isTablet ? 380 : 250;
    final double? compH = isTablet ? 300 : null;

    // ---- HELPERS ----
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
              child: Text(
                text,
                style: TextStyle(color: textPrimary, fontWeight: bold ? FontWeight.w800 : FontWeight.w600),
                softWrap: true,
              ),
            ),
          ],
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
    Widget specCard(List<String> points, {double? height}) => Container(
          height: height,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: specPill()),
              SizedBox(height: isTablet ? 16 : 12),
              for (int i = 0; i < points.length; i++) ...[
                bullet(points[i], bold: i == 0),
                const SizedBox(height: 8),
              ],
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ===== TABEL VARIAN (di atas perbandingan) =====
    Widget th(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: headerDark,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: headerText, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget td(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          alignment: Alignment.center,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
        );

    // ⬇️ Sel berwarna full untuk kolom "Warna"
    Widget tdFullColor(String text, Color bg) => Container(
          color: bg,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget specTable() {
      final rows = [
        {
          'watt': '9 w/m',
          'lumen': '120lm/watt',
          'ukuran': '5000mm x 8mm x 3mm',
          'warna': '6500K',
          'color': accentBlue,
          'ket': 'Cahaya Putih Kebiruan',
        },
        {
          'watt': '9 w/m',
          'lumen': '120lm/watt',
          'ukuran': '5000mm x 8mm x 3mm',
          'warna': '3000K',
          'color': accentYellow,
          'ket': 'Cahaya Putih Kekuningan',
        },
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(110),
          1: FixedColumnWidth(130),
          2: FixedColumnWidth(210),
          3: FixedColumnWidth(110),
          4: FixedColumnWidth(210),
        },
        children: [
          TableRow(children: [
            th('Varian Watt'),
            th('Lumen'),
            th('Ukuran'),
            th('Warna'),
            th('Keterangan'),
          ]),
          for (final r in rows)
            TableRow(children: [
              td(r['watt'] as String),
              td(r['lumen'] as String),
              td(r['ukuran'] as String),
              tdFullColor(r['warna'] as String, r['color'] as Color), // FULL warna
              td(r['ket'] as String),
            ]),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    // Perbandingan: hanya judul + gambar
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesNanoScreen()),
              );
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

            Text('Product Indoor',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vPad),

            // HERO: gambar + spesifikasi
            LayoutBuilder(builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;
              final img = productImage('assets/images/indoornano.jpg', height: row ? heroH : null);
              final spec = specCard(const [
                'Tahan Sampai: 25.000 Jam',
                'LED: 60-2835',
                'Hemat Energi: 90%',
                'CRI: >80',
                'IP: 33',
              ], height: row ? heroH : null);

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

            // ===== TABEL VARIAN =====
            specTable(),

            SizedBox(height: vPad * 1.5),

            // PERBANDINGAN
            if (isTablet) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: comparisonImageBlock(title: 'NANOLITE', imagePath: 'assets/images/innano.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: comparisonImageBlock(title: 'PRODUK LAIN', imagePath: 'assets/images/inkom.jpg'),
                  ),
                ],
              ),
            ] else ...[
              comparisonImageBlock(title: 'NANOLITE', imagePath: 'assets/images/innano.jpg'),
              SizedBox(height: vPad * 1.5),
              comparisonImageBlock(title: 'PRODUK LAIN', imagePath: 'assets/images/inkom.jpg'),
            ],
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen())),
              ),
              IconButton(
                icon: const Icon(Icons.add_box_rounded),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => CreateSalesOrderScreen())),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ProfileScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
