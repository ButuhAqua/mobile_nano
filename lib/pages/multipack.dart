// lib/pages/multipack.dart
import 'package:flutter/material.dart';

import 'categories_nano.dart';
import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class MultipackPage extends StatelessWidget {
  const MultipackPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ---- THEME ----
    const Color bgTop = Color(0xFF0B2741);
    const Color bgBottom = Color(0xFF0E3556);
    const Color card = Color(0xFF0F2D4B);
    const Color chip = Color(0xFF163E66);
    const Color textPrimary = Colors.white;

    // Tabel
    const Color headerDark = Color(0xFF0B2741);
    const Color accentBlue = Color(0xFF03A9F4);   // 6500K
    const Color accentYellow = Color(0xFFFFC107); // 3000K

    // ---- RESPONSIVE ----
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;

    final double hPad = isTablet ? 24 : 16;
    final double vGap = isTablet ? 18 : 12;
    final double productCardH = isTablet ? 300 : 220; // tinggi gambar tetap
    final double specFont = isTablet ? 16 : 14;

    // ---------- Card Builders ----------
    Widget imageCard() => Container(
          height: productCardH,
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/multipack.jpg',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) =>
                  const Center(child: Icon(Icons.broken_image, color: Colors.white70, size: 48)),
            ),
          ),
        );

    // Spesifikasi sesuai Gambar 1
    Widget specCard({double? height}) => Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SpecHeader(),
              SizedBox(height: isTablet ? 14 : 12),
              _BulletSpec('Tahan Sampai', '25.000 Jam', fontSize: specFont),
              _BulletSpec('Fitting', 'E27', fontSize: specFont),
              _BulletSpec('Hemat Energi', '90%', fontSize: specFont),
              _BulletSpec('LED', 'Samsung', fontSize: specFont),
              _BulletSpec('Tegangan', '110–240V', fontSize: specFont),
              if (height != null) const Spacer(),
            ],
          ),
        );

    // ------- TABLE (sesuai Gambar 2) -------
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

    // warna sel background penuh + teks putih
    Widget tdColor(String text, Color bg) => Container(
          color: bg,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
        );

    Widget specTable() {
      final rows = [
        {
          'watt': '5 Watt',
          'lumen': '600lm',
          'dim': '105mm x 55mm',
          'isi': '24',
          'warna1': tdColor('6500K', accentBlue),
          'ket1': 'Cahaya Putih Kebiruan',
          'warna2': tdColor('3000K', accentYellow),
          'ket2': 'Cahaya Putih Kekuningan',
        },
        {
          'watt': '12 Watt',
          'lumen': '1440lm',
          'dim': '125,5mm x 65mm',
          'isi': '24',
          'warna1': tdColor('6500K', accentBlue),
          'ket1': 'Cahaya Putih Kebiruan',
          'warna2': tdColor('3000K', accentYellow),
          'ket2': 'Cahaya Putih Kekuningan',
        },
      ];

      final table = Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: Colors.white24, width: 1),
        columnWidths: const {
          0: FixedColumnWidth(110),
          1: FixedColumnWidth(110),
          2: FixedColumnWidth(190),
          3: FixedColumnWidth(70),
          4: FixedColumnWidth(90),
          5: FixedColumnWidth(200),
          6: FixedColumnWidth(90),
          7: FixedColumnWidth(200),
        },
        children: [
          TableRow(children: [
            th('Varian Watt'),
            th('Lumen'),
            th('Dimensi (Tinggi x Diameter)'),
            th('Isi/Dus'),
            th('Warna'),
            th('Keterangan'),
            th('Warna'),
            th('Keterangan'),
          ]),
          for (final r in rows)
            TableRow(children: [
              tdText(r['watt'] as String),
              tdText(r['lumen'] as String),
              tdText(r['dim'] as String),
              tdText(r['isi'] as String),
              r['warna1'] as Widget,
              tdText(r['ket1'] as String),
              r['warna2'] as Widget,
              tdText(r['ket2'] as String),
            ]),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    return Scaffold(
      backgroundColor: bgBottom,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgTop,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
        title: const Text('nanopiko', style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [bgTop, bgBottom]),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(hPad, vGap, hPad, vGap + 12),
          children: [
            // Brand chip
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: chip, borderRadius: BorderRadius.circular(32)),
                  child: const Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Nanolite', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: vGap),

            Text('Product Multipack',
                style: TextStyle(color: textPrimary, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
            SizedBox(height: vGap),

            // Hero: Gambar + Spesifikasi
            LayoutBuilder(builder: (context, c) {
              final isWideRow = isTablet && c.maxWidth >= 680;
              if (isWideRow) {
                return Row(children: [
                  Expanded(child: imageCard()),
                  const SizedBox(width: 12),
                  Expanded(child: specCard(height: productCardH)),
                ]);
              }
              return Column(children: [imageCard(), SizedBox(height: vGap), specCard()]);
            }),

            SizedBox(height: vGap),

            // ===== TABEL VARIAN =====
            specTable(),
          ],
        ),
      ),
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
}

// ---------- Widgets Kecil ----------
class _SpecHeader extends StatelessWidget {
  const _SpecHeader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(24)),
        child: const Text('Spesifikasi', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _BulletSpec extends StatelessWidget {
  final String title;
  final String value;
  final double fontSize;
  const _BulletSpec(this.title, this.value, {required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 7), child: Icon(Icons.circle, size: 6, color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: fontSize, color: Colors.white),
                children: [
                  TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w800)),
                  TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom bar item
Widget _navItem(IconData icon, String label, {required VoidCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(10),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black87),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 12)),
        ],
      ),
    ),
  );
}
