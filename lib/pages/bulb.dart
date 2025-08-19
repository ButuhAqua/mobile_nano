import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class BulbScreen extends StatelessWidget {
  const BulbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1B2D),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('nanopiko', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
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
            const SizedBox(height: 16),

            // Title
            Text(
              'Product Bulb',
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // HERO: image + spesifikasi
            LayoutBuilder(
              builder: (context, c) {
                final sideBySide = isTablet && c.maxWidth >= 680;

                final img = Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1B2D), // nyatu dengan bg
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Center(
                    child: Image.asset(
                      'assets/images/spekbulb.png',
                      width: isTablet ? 320 : 260,
                      fit: BoxFit.contain,
                    ),
                  ),
                );

                const spec = _SpecCard();

                if (sideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: img),
                      const SizedBox(width: 16),
                      const Expanded(child: _SpecCard()),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    img,
                    const SizedBox(height: 12),
                    spec,
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // TABLE (rapi & konsisten)
            _VariantTable(isTablet: isTablet),

            const SizedBox(height: 30),

            // Perbandingan (gambar saja)
            Text(
              'Perbandingan:',
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final twoCols = isTablet && constraints.maxWidth >= 680;

                final left = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/nanobulbspek.png',
                    height: isTablet ? 220 : 170,
                    fit: BoxFit.contain,
                  ),
                );
                final right = Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/productkomp.png',
                    height: isTablet ? 220 : 170,
                    fit: BoxFit.contain,
                  ),
                );

                if (twoCols) {
                  return Row(children: [Expanded(child: left), Expanded(child: right)]);
                }
                return Column(children: [left, right]);
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),

      // Bottom nav
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

/// ===== Kartu spesifikasi (header bar terang) =====
class _SpecCard extends StatelessWidget {
  const _SpecCard({super.key});

  @override
  Widget build(BuildContext context) {
    final header = Container(
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
      child: Padding(
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
                children: [
                  row('Tahan Sampai', '25.000 Jam'),
                  row('Fitting', 'E27'),
                  row('Hemat Energi', '90%'),
                  row('LED', 'Samsung'),
                  row('Tegangan', '110–240V'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== Tabel varian (rapi; lebar & tinggi seragam; grid single) =====
class _VariantTable extends StatelessWidget {
  final bool isTablet;
  const _VariantTable({required this.isTablet, super.key});

  @override
  Widget build(BuildContext context) {
    const bgPage = Color(0xFF0A1B2D);
    const headerLight = Color(0xFFE9ECEF);
    const blue6500 = Color(0xFF1EA7FF);
    const yellow3000 = Color(0xFFFFC107);

    // Data 8 kolom — HARUS konsisten
    const rows = [
      ['5 Watt','840lm','115mm','60mm','100','3000K','6500K','Rp 30.900'],
      ['7 Watt','600lm','105mm','55mm','100','3000K','6500K','Rp 23.900'],
      ['9 Watt','1080lm','110mm','65mm','100','3000K','6500K','Rp 35.900'],
      ['12 Watt','1440lm','125.5mm','55mm','100','3000K','6500K','Rp 42.900'],
      ['15 Watt','1800lm','137.5mm','69.8mm','100','3000K','6500K','Rp 50.900'],
    ];

    // Lebar kolom dipatok supaya tidak shifting
    final columnWidths = isTablet
        ? const <int, TableColumnWidth>{
            0: FixedColumnWidth(92),
            1: FixedColumnWidth(90),
            2: FixedColumnWidth(96),
            3: FixedColumnWidth(96),
            4: FixedColumnWidth(70),
            5: FixedColumnWidth(96),
            6: FixedColumnWidth(108),
            7: FixedColumnWidth(112),
          }
        : const <int, TableColumnWidth>{
            0: FixedColumnWidth(104),
            1: FixedColumnWidth(92),
            2: FixedColumnWidth(96),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(72),
            5: FixedColumnWidth(98),
            6: FixedColumnWidth(110),
            7: FixedColumnWidth(116),
          };

    // Header & cell builders dengan tinggi seragam
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
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, height: 1.1),
            ),
          ),
    );

    Widget tdColor(String t, Color bg, {bool dark = false}) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            color: bg,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              style: TextStyle(
                color: dark ? Colors.black : Colors.white,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
          ),
    );

    final table = Table(
      // gunakan symmetric agar garis grid tidak dobel/tebal
      border: const TableBorder.symmetric(
        inside: BorderSide(color: Colors.white24, width: 1),
        outside: BorderSide(color: Colors.white24, width: 1),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: columnWidths,
      children: [
        TableRow(children: [
          th('Watt'),
          th('Lumen'),
          th('Tinggi'),
          th('Diameter'),
          th('Isi/Dus'),
          th('Warm\nWhite'),
          th('Cool Day\nLight'),
          th('Harga'),
        ]),
        for (final r in rows)
          TableRow(
            decoration: const BoxDecoration(color: bgPage),
            children: [
              td(r[0]),
              td(r[1]),
              td(r[2]),
              td(r[3]),
              td(r[4]),
              tdColor(r[5], yellow3000, dark: true),
              tdColor(r[6], blue6500),
              td(r[7]),
            ],
          ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: bgPage, // frame nyatu dengan background
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTablet
          ? table
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: table,
            ),
    );
  }
}
