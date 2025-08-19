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
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;

    // ========= COLORS =========
    const Color kBg = Color(0xFF0A1B2D); // background utama & tepi tabel
    const Color kCard = Color(0xFF10263A); // kartu gelap sedikit lebih terang dari bg
    const Color kText = Colors.white;

    // ---------- Brand chip ----------
    Widget brandChip() => Container(
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
        );

    // ---------- HERO: image + spec dalam SATU card/border ----------
    Widget specPill() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'SPESIFIKASI',
              style: TextStyle(
                color: Colors.blueGrey.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );

    Widget specRow(String l, String r) => Padding(
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

    Widget heroCard() => Container(
          decoration: BoxDecoration(
            color: kCard,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, c) {
              final row = isTablet && c.maxWidth >= 680;

              final img = Center(
                child: Image.asset(
                  'assets/images/downlsquare.jpg', // ganti dengan gambar yang sesuai
                  height: row ? 300 : 220,
                  fit: BoxFit.contain,
                ),
              );

              final specWhite = Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    specPill(),
                    const SizedBox(height: 8),
                    specRow('Tahan Sampai', '25.000 Jam'),
                    specRow('Slim desain (H)', '26mm'),
                    specRow('Hemat Energi', '90%'),
                    specRow('CRI', '>80'),
                    specRow('IP', '20'),
                    specRow('Beam Angle', '120°'),
                  ],
                ),
              );

              if (row) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: img),
                    const SizedBox(width: 16),
                    Expanded(child: specWhite),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  img,
                  const SizedBox(height: 12),
                  specWhite,
                ],
              );
            },
          ),
        );

    // ---------- TABLE ----------
    Widget th(String text) => Container(
          color: const Color(0xFFE9ECEF),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Center(
            child: Text(text,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        );

    Widget tdText(String text) => Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
        );

    Widget tdColor(String text, Color bg, {bool dark = false}) => Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.center,
          color: bg,
          child: Text(text,
              style: TextStyle(
                color: dark ? Colors.black : Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              )),
        );

    Widget specTable() {
      final rows = [
        ['5 Watt',  '600lm',  '95mm',  '100', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['9 Watt',  '1080lm', '118mm', '100', '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['12 Watt', '1440lm', '145mm', '60',  '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['15 Watt', '1800lm', '170mm', '60',  '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
        ['18 Watt', '2160lm', '220mm', '40',  '6500K', 'Cahaya Putih Kebiruan', '4000K', 'Cahaya Natural', '3000K', 'Cahaya Putih Kekuningan'],
      ];

      final table = Table(
        border: TableBorder.all(color: Colors.white24, width: 1),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFF0F2D4B)),
              children: [
                tdText(r[0]),
                tdText(r[1]),
                tdText(r[2]),
                tdText(r[3]),
                tdColor(r[4], const Color(0xFF1EA7FF)),
                tdText(r[5]),
                tdColor(r[6], const Color(0xFFBDBDBD), dark: true),
                tdText(r[7]),
                tdColor(r[8], const Color(0xFFFFC107)),
                tdText(r[9]),
              ],
            ),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: kCard, borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: table),
      );
    }

    // ---------- Perbandingan (gambar saja) ----------
    Widget comparisonImages() => LayoutBuilder(
          builder: (context, c) {
            final row = isTablet && c.maxWidth >= 680;

            final left = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/nanobulbspek.png', // Produk Nanolite
                height: isTablet ? 220 : 170,
                fit: BoxFit.contain,
              ),
            );
            final right = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/productkomp.png', // Produk lain
                height: isTablet ? 220 : 170,
                fit: BoxFit.contain,
              ),
            );

            if (row) {
              return Row(
                children: [Expanded(child: left), const SizedBox(width: 12), Expanded(child: right)],
              );
            }
            return Column(children: [left, right]);
          },
        );

    // ================= PAGE =================
    return Scaffold(
      backgroundColor: kBg,
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
      body: ListView(
        padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 16),
        children: [
          brandChip(),
          SizedBox(height: vPad),
          Text('Product Downlight Round',
              style: TextStyle(color: kText, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
          SizedBox(height: vPad),
          heroCard(),
          SizedBox(height: vPad),
          specTable(),
          SizedBox(height: vPad * 1.5),
          Text('Perbandingan:',
              style: TextStyle(color: kText, fontWeight: FontWeight.w700, fontSize: isTablet ? 16 : 15)),
          SizedBox(height: vPad),
          comparisonImages(),
        ],
      ),

      // ---------- Bottom nav ----------
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
