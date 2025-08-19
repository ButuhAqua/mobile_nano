import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class CapsuleScreen extends StatelessWidget {
  const CapsuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // === PALETTE (sama seperti Bulb/TBulb/ABulb) ===
    const Color bgPage = Color(0xFF0A1B2D);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);

    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final double padding = isTablet ? 30.0 : 16.0;
    final double comparisonImageHeight = isTablet ? 220 : 180;

    // --- brand chip abu-abu ---
    Widget brandChip() => Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lightbulb, color: Colors.black),
                SizedBox(width: 8),
                Text("Nanolite", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        );

    // --- hero image ---
    Widget imageCard() => Container(
          decoration: BoxDecoration(
            color: bgPage,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Image.asset(
              "assets/images/capsule.jpg",
              width: isTablet ? 320 : 260,
              fit: BoxFit.contain,
            ),
          ),
        );

    // --- spec card: header bar abu-abu + body putih ---
    Widget specCard() => Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _SpecHeaderBar(),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SpecRow(label: 'Tahan Sampai', value: '25.000 Jam'),
                    _SpecRow(label: 'Fitting', value: 'E27'),
                    _SpecRow(label: 'Hemat Energi', value: '90%'),
                    _SpecRow(label: 'LED', value: 'Samsung'),
                    _SpecRow(label: 'Tegangan', value: '110–240V'),
                  ],
                ),
              ),
            ],
          ),
        );

    // --- table builders (gaya seragam) ---
    Widget th(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Container(
            color: headerLight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              t,
              textAlign: TextAlign.center,
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

    Widget tdBlue(String t) => ConstrainedBox(
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

    // --- capsule spec table (6 kolom) ---
    Widget capsuleTable() {
      final rows = [
        ["30 Watt", "3600lm", "178mm x 100mm", "40", "6500K", "Cahaya Putih Kebiruan"],
        ["50 Watt", "6000lm", "211mm x 120mm", "24", "6500K", "Cahaya Putih Kebiruan"],
      ];

      // HP fixed width + horizontal scroll; tablet fleksibel
      const phoneWidths = <int, TableColumnWidth>{
        0: FixedColumnWidth(130), // Varian Watt
        1: FixedColumnWidth(120), // Lumen
        2: FixedColumnWidth(220), // Dimensi
        3: FixedColumnWidth(90),  // Isi/Dus
        4: FixedColumnWidth(110), // Warna
        5: FixedColumnWidth(240), // Keterangan
      };
      final tabletWidths = <int, TableColumnWidth>{
        0: const FlexColumnWidth(1.1),
        1: const FlexColumnWidth(1.0),
        2: const FlexColumnWidth(1.7),
        3: const FlexColumnWidth(0.9),
        4: const FlexColumnWidth(0.9),
        5: const FlexColumnWidth(1.9),
      };

      final table = Table(
        columnWidths: isTablet ? tabletWidths : phoneWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder.symmetric(
          inside: BorderSide(color: Colors.white24, width: 1),
          outside: BorderSide(color: Colors.white24, width: 1),
        ),
        children: [
          TableRow(children: [
            th("Varian Watt"),
            th("Lumen"),
            th("Dimensi (Tinggi x Diameter)"),
            th("Isi/Dus"),
            th("Warna"),
            th("Keterangan"),
          ]),
          for (var r in rows)
            TableRow(
              decoration: const BoxDecoration(color: bgPage),
              children: [
                td(r[0]),
                td(r[1]),
                td(r[2]),
                td(r[3]),
                tdBlue(r[4]),
                td(r[5]),
              ],
            ),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: bgPage, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(10),
        child: isTablet
            ? table
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 910), child: table),
              ),
      );
    }

    return Scaffold(
      backgroundColor: bgPage,
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
            brandChip(),
            const SizedBox(height: 16),
            const Text("Product Capsule",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),

            // HERO (tablet row, HP stack)
            LayoutBuilder(
              builder: (context, constraints) {
                final bool sideBySide = isTablet && constraints.maxWidth >= 680;
                if (sideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: imageCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 6, child: specCard()),
                    ],
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imageCard(),
                    const SizedBox(height: 12),
                    specCard(),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // TABLE (gaya seragam)
            capsuleTable(),

            const SizedBox(height: 24),
            const Text("Perbandingan:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Perbandingan gambar
            LayoutBuilder(
              builder: (context, constraints) {
                final twoCols = isTablet && constraints.maxWidth >= 680;

                final left = Image.asset(
                  "assets/images/nanocapspek.jpg",
                  height: comparisonImageHeight,
                  fit: BoxFit.contain,
                );
                final right = Image.asset(
                  "assets/images/kompcaps.jpg",
                  height: comparisonImageHeight,
                  fit: BoxFit.contain,
                );

                if (twoCols) {
                  return Row(
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 12),
                      Expanded(child: right),
                    ],
                  );
                }
                return Column(children: [left, const SizedBox(height: 12), right]);
              },
            ),

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

  // Bottom nav item
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

// ====== sub-widgets ======

class _SpecHeaderBar extends StatelessWidget {
  const _SpecHeaderBar();

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
