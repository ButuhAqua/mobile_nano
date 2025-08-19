// lib/pages/a_bulb.dart (ABulbScreen)
import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class ABulbScreen extends StatelessWidget {
  const ABulbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Palette mengikuti gaya Bulb/TBulb
    const Color bgPage = Color(0xFF0A1B2D);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);
    const Color yellow3000 = Color(0xFFFFC107);

    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;

    // Brand chip abu-abu
    Widget brandChip() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(24)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.black),
              SizedBox(width: 8),
              Text('Pikolite', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    // Hero image menyatu dengan background
    Widget productImage() => Container(
          decoration: BoxDecoration(color: bgPage, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Image.asset('assets/images/spekabulb1.png',
                height: isTablet ? 220 : 210, fit: BoxFit.contain),
          ),
        );

    // Kartu spesifikasi: header bar abu-abu
    Widget specCard() {
      Widget header = Container(
        width: double.infinity,
        height: 42,
        decoration: const BoxDecoration(
          color: headerLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: const Center(
          child: Text('SPESIFIKASI', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
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
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                    row('Tahan Sampai', '15.000 Jam'),
                    row('Fitting', 'E27'),
                    row('Hemat Energi', '90%'),
                    row('Lumen', '100lm/Watt'),
                    row('Tegangan', '110–240V'),
                    row('CRI', '>80Ra'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ===== Table builders (rapi & seragam) =====
    Widget th(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Container(
            color: headerLight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(t,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, height: 1.1)),
          ),
        );

    Widget td(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(t,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, height: 1.1)),
          ),
        );

    Widget tdBadge(String t, Color bg, {bool dark = false}) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            color: bg,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(t,
                style: TextStyle(
                    color: dark ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.1)),
          ),
        );

    Widget specTable() {
      // Data A-Bulb (6 kolom)
      const rows = [
        ['3 Watt',  '115mm',  '60mm',   '3000K', '6500K', 'Rp 12.900'],
        ['5 Watt',  '115mm',  '60mm',   '3000K', '6500K', 'Rp 14.900'],
        ['7 Watt',  '115mm',  '55mm',   '3000K', '6500K', 'Rp 16.900'],
        ['9 Watt',  '125.5mm','65mm',   '3000K', '6500K', 'Rp 18.900'],
        ['12 Watt', '125.5mm','65mm',   '3000K', '6500K', 'Rp 19.900'],
        ['15 Watt', '137.5mm','69.8mm', '3000K', '6500K', 'Rp 25.900'],
      ];

      // Lebar kolom tetap agar tidak “geser-geser”
      const phoneWidths = <int, TableColumnWidth>{
        0: FixedColumnWidth(110),
        1: FixedColumnWidth(110),
        2: FixedColumnWidth(120),
        3: FixedColumnWidth(120),
        4: FixedColumnWidth(130),
        5: FixedColumnWidth(120),
      };
      final tabletWidths = <int, TableColumnWidth>{
        0: const FlexColumnWidth(1.0),
        1: const FlexColumnWidth(1.0),
        2: const FlexColumnWidth(1.1),
        3: const FlexColumnWidth(1.0),
        4: const FlexColumnWidth(1.1),
        5: const FlexColumnWidth(1.0),
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
            th('Watt'),
            th('Tinggi'),
            th('Diameter'),
            th('Warm White'),
            th('Cool Day Light'),
            th('Harga'),
          ]),
          for (final r in rows)
            TableRow(
              decoration: const BoxDecoration(color: bgPage),
              children: [
                td(r[0]),
                td(r[1]),
                td(r[2]),
                tdBadge(r[3], yellow3000), // teks default: putih
                tdBadge(r[4], blue6500),
                td(r[5]),
              ],
            ),
        ],
      );

      return Container(
        decoration: BoxDecoration(color: bgPage, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
        child: isTablet
            ? table
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 710), child: table),
              ),
      );
    }

    return Scaffold(
      backgroundColor: bgPage,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('nanopiko', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 16),
        children: [
          brandChip(),
          SizedBox(height: vPad),
          Text('Product A-Bulb',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
          SizedBox(height: vPad),

          // HERO (row di tablet, stack di HP)
          LayoutBuilder(builder: (context, c) {
            final row = isTablet && c.maxWidth >= 680;
            final img = productImage();
            final spec = specCard();
            if (row) {
              return Row(children: [Expanded(child: img), const SizedBox(width: 16), Expanded(child: spec)]);
            }
            return Column(children: [img, const SizedBox(height: 12), spec]);
          }),

          SizedBox(height: vPad),

          // TABLE
          specTable(),

          SizedBox(height: vPad * 1.5),

          // Perbandingan (gambar saja, konsisten dengan halaman lain)
          LayoutBuilder(builder: (context, c) {
            final twoCols = isTablet && c.maxWidth >= 680;
            final left = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/nanobulbspek.png',
                  height: isTablet ? 220 : 170, fit: BoxFit.contain),
            );
            final right = Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/productkomp.png',
                  height: isTablet ? 220 : 170, fit: BoxFit.contain),
            );
            if (twoCols) return Row(children: [Expanded(child: left), Expanded(child: right)]);
            return Column(children: [left, right]);
          }),
        ],
      ),

      // Bottom nav (sama gaya)
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
