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
    // === PALETTE (mengikuti Bulb page) ===
    const Color bgPage = Color(0xFF0A1B2D);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);

    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;

    // ---- Brand chip abu-abu (ikon & teks hitam) ----
    Widget brandChip() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(24)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.black),
              SizedBox(width: 8),
              Text('Nanolite', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            ],
          ),
        );

    // ---- Hero image: menyatu dengan background ----
    Widget productImage() => Container(
          decoration: BoxDecoration(color: bgPage, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/tbulbpiko.jpg',
              height: isTablet ? 220 : 170, fit: BoxFit.contain),
        );

    // ---- Kartu spesifikasi: header bar abu-abu seperti Bulb ----
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
                  const TextSpan(text: ''), // agar tidak error saat copy
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // isi spesifikasi T-Bulb (boleh kamu sesuaikan)
                    _SpecRow(label: 'Tahan Sampai', value: '15.000 Jam'),
                    _SpecRow(label: 'Fitting', value: 'E27'),
                    _SpecRow(label: 'Hemat Energi', value: '90%'),
                    _SpecRow(label: 'Tegangan', value: '110–240V'),
                    _SpecRow(label: 'CRI', value: '>80Ra'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ---- Header & cell builder tabel (gaya Bulb) ----
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

    Widget tdBlue(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            color: blue6500,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, height: 1.1)),
          ),
        );

    // ---- Tabel T-Bulb (kolom: Varian Watt | Dimensi Produk | Harga | Warna | Keterangan) ----
    Widget specTable() {
      const rows = [
        ['5 Watt', '45mm x 100mm', 'Rp 13.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['10 Watt', '59mm x 115mm', 'Rp 20.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['15 Watt', '69mm x 133mm', 'Rp 25.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['20 Watt', '80mm x 145mm', 'Rp 32.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['30 Watt', '100mm x 180mm', 'Rp 46.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['40 Watt', '113mm x 200mm', 'Rp 65.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['50 Watt', '113mm x 215mm', 'Rp 80.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['60 Watt', '113.4mm x 215mm', 'Rp 93.900', '6500K', 'Cahaya Putih Kebiruan'],
      ];

      // Lebar kolom tetap agar rapi
      const phoneWidths = <int, TableColumnWidth>{
        0: FixedColumnWidth(120), // Varian Watt
        1: FixedColumnWidth(200), // Dimensi
        2: FixedColumnWidth(140), // Harga
        3: FixedColumnWidth(90),  // Warna
        4: FixedColumnWidth(220), // Keterangan
      };
      final tabletWidths = <int, TableColumnWidth>{
        0: const FlexColumnWidth(1.1),
        1: const FlexColumnWidth(1.6),
        2: const FlexColumnWidth(1.1),
        3: const FlexColumnWidth(.9),
        4: const FlexColumnWidth(1.6),
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
            th('Varian Watt'),
            th('Dimensi Produk'),
            th('Harga'),
            th('Warna'),
            th('Keterangan'),
          ]),
          for (final r in rows)
            TableRow(
              decoration: const BoxDecoration(color: bgPage),
              children: [td(r[0]), td(r[1]), td(r[2]), tdBlue(r[3]), td(r[4])],
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
                child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 750), child: table),
              ),
      );
    }

    // ---- Page ----
    return Scaffold(
      backgroundColor: bgPage,
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
          Text('Product T-Bulb',
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

          // Perbandingan (gambar saja, seperti Bulb page)
          LayoutBuilder(builder: (context, c) {
            final twoCols = isTablet && c.maxWidth >= 680;
            final left = Image.asset('assets/images/tpiko.jpg', height: isTablet ? 170 : 150, fit: BoxFit.contain);
            final right = Image.asset('assets/images/tkom.jpg', height: isTablet ? 170 : 150, fit: BoxFit.contain);
            if (twoCols) {
              return Row(children: [Expanded(child: left), const SizedBox(width: 16), Expanded(child: right)]);
            }
            return Column(children: [left, const SizedBox(height: 12), right]);
          }),
        ],
      ),

      // Bottom nav (sama seperti Bulb)
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
    );
  }
}

// ---- helper kecil ----
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

Widget _navItem(IconData icon, String label, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
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
