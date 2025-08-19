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
    // === PALETTE: samakan dengan Bulb/TBulb ===
    const Color bgPage = Color(0xFF0A1B2D);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);

    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final double hPad = isTablet ? 24 : 16;
    final double vPad = isTablet ? 18 : 12;

    // Brand chip abu-abu (ikon & teks hitam)
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

    // HERO image: nyatu dengan background
    Widget productImage() => Container(
          decoration: BoxDecoration(color: bgPage, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12),
          child: Image.asset('assets/images/multipikko.jpg', height: isTablet ? 260 : 210, fit: BoxFit.contain),
        );

    // Kartu spesifikasi: header bar abu-abu muda + body putih
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

      return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // header
              SizedBox(height: 0, child: SizedBox.shrink()),
            ],
          ),
        ),
      );
    }

    // versi dengan isi
    Widget specCardFilled() {
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

      return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // header sudah di atas
              SizedBox(height: 0, child: SizedBox.shrink()),
            ],
          ),
        ),
      );
    }

    // helper row untuk spesifikasi
    Widget specRows() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _SpecRow(label: 'Tahan Sampai', value: '25.000 Jam'),
              _SpecRow(label: 'Fitting', value: 'E27'),
              _SpecRow(label: 'Hemat Energi', value: '90%'),
              _SpecRow(label: 'LED', value: 'Samsung'),
              _SpecRow(label: 'Tegangan', value: '110–240V'),
            ],
          ),
        );

    // ====== TABLE builders (gaya ABulb/TBulb) ======
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

    // ====== TABLE data & layout ======
    Widget specTable() {
      const rows = [
        ['5 Watt',  '55mm x 102mm', 'Rp 45.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['7 Watt',  '59mm x 115mm', 'Rp 51.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['9 Watt',  '59mm x 115mm', 'Rp 59.900', '6500K', 'Cahaya Putih Kebiruan'],
        ['12 Watt', '64mm x 123mm', 'Rp 68.900', '6500K', 'Cahaya Putih Kebiruan'],
      ];

      // Lebar kolom (HP fixed + scroll; Tablet fleksibel)
      const phoneWidths = <int, TableColumnWidth>{
        0: FixedColumnWidth(140), // Varian Watt
        1: FixedColumnWidth(220), // Dimensi Produk
        2: FixedColumnWidth(160), // Harga
        3: FixedColumnWidth(110), // Warna
        4: FixedColumnWidth(240), // Keterangan
      };
      final tabletWidths = <int, TableColumnWidth>{
        0: const FlexColumnWidth(1.1),
        1: const FlexColumnWidth(1.6),
        2: const FlexColumnWidth(1.2),
        3: const FlexColumnWidth(0.9),
        4: const FlexColumnWidth(1.7),
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
                child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 870), child: table),
              ),
      );
    }

    // ---- PAGE ----
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
                MaterialPageRoute(builder: (_) => CategoriesPikoScreen()),
              );
            }
          },
        ),
        title: const Text('pikolite', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad + 16),
        children: [
          brandChip(),
          SizedBox(height: vPad),
          Text('Product Multipack',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: isTablet ? 18 : 16)),
          SizedBox(height: vPad),

          // HERO (row di tablet, stack di HP)
          LayoutBuilder(builder: (context, c) {
            final row = isTablet && c.maxWidth >= 680;
            final img = productImage();

            // spec card lengkap (header + isi)
            final spec = Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: headerLight,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Center(
                      child: Text('SPESIFIKASI',
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
                    ),
                  ),
                  specRows(),
                ],
              ),
            );

            if (row) {
              return Row(children: [Expanded(child: img), const SizedBox(width: 16), Expanded(child: spec)]);
            }
            return Column(children: [img, const SizedBox(height: 12), spec]);
          }),

          SizedBox(height: vPad),

          // TABLE
          specTable(),
        ],
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

// ===== Helpers =====
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
          style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
