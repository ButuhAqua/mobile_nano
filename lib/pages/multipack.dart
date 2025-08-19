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
    final bool isTablet = MediaQuery.of(context).size.width >= 600;

    // Palette
    const Color bgPage     = Color(0xFF0E3556);
    const Color cardDark   = Color(0xFF0F2D4B);
    const Color headerLight= Color(0xFFE9ECEF);
    const Color blue6500   = Color(0xFF1EA7FF);

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
      ),

      body: ListView(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
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

          const Text(
            'Product Multipack',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // HERO
          LayoutBuilder(
            builder: (context, c) {
              final bool sideBySide = isTablet && c.maxWidth >= 680;

              final img = Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: cardDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/images/multipack.jpg',
                    width: isTablet ? 320 : 240,
                    fit: BoxFit.contain,
                  ),
                ),
              );

              final spec = const _HeroSpecCard(
                items: [
                  ['Tahan Sampai', '25.000 Jam'],
                  ['Fitting', 'E27'],
                  ['Hemat Energi', '90%'],
                  ['LED', 'Samsung'],
                  ['Tegangan', '110–240V'],
                ],
              );

              if (sideBySide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: img),
                    const SizedBox(width: 16),
                    const Expanded(child: _HeroSpecCard(
                      items: [
                        ['Tahan Sampai', '25.000 Jam'],
                        ['Fitting', 'E27'],
                        ['Hemat Energi', '90%'],
                        ['LED', 'Samsung'],
                        ['Tegangan', '110–240V'],
                      ],
                    )),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  img,
                  const SizedBox(height: 12),
                  const _HeroSpecCard(
                    items: [
                      ['Tahan Sampai', '25.000 Jam'],
                      ['Fitting', 'E27'],
                      ['Hemat Energi', '90%'],
                      ['LED', 'Samsung'],
                      ['Tegangan', '110–240V'],
                    ],
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 24),

          // TABEL VARIAN — styling mengikuti ABulbScreen
          _SpecTable(isTablet: isTablet),
        ],
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
}

/// ===== KARTU SPESIFIKASI =====
class _HeroSpecCard extends StatelessWidget {
  final List<List<String>> items;
  const _HeroSpecCard({required this.items});

  static const _navy = Color(0xFF0E2A47);

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text('$label:',
                style: const TextStyle(color: _navy, fontWeight: FontWeight.w800, height: 1.3)),
          ),
          Expanded(
            flex: 7,
            child: Text(value,
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, height: 1.3)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 14, offset: const Offset(0, 6))],
      ),
      child: Column(
        children: [
          Container(
            height: 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F4F8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Text('SPESIFIKASI',
                style: TextStyle(color: _navy, fontWeight: FontWeight.w800, letterSpacing: .3)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(children: [for (final r in items) _row(r[0], r[1])]),
          ),
        ],
      ),
    );
  }
}

/// ===== TABEL VARIAN (match ABulbScreen style) =====
class _SpecTable extends StatelessWidget {
  final bool isTablet;
  const _SpecTable({required this.isTablet});

  @override
  Widget build(BuildContext context) {
    const Color bgPage   = Color(0xFF0E3556);
    const Color cardDark = Color(0xFF0F2D4B);
    const Color headerLight = Color(0xFFE9ECEF);
    const Color blue6500 = Color(0xFF1EA7FF);

    // Data Multipack (5 kolom)
    const rows = [
      ['5 Watt',  '105mm x 55mm',   'Rp 23.900', '6500K', 'Cahaya Putih Kebiruan'],
      ['12 Watt', '125.5mm x 65mm', 'Rp 42.900', '6500K', 'Cahaya Putih Kebiruan'],
    ];

    // === Builders: sama persis pola ABulb (center, tinggi seragam) ===
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

    Widget tdBadge(String t) => ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 42),
          child: Container(
            alignment: Alignment.center,
            color: blue6500,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(t,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, height: 1.1)),
          ),
        );

    // Lebar kolom—kunci agar rapi
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
            children: [td(r[0]), td(r[1]), td(r[2]), tdBadge(r[3]), td(r[4])],
          ),
      ],
    );

    return Container(
      decoration: BoxDecoration(color: cardDark, borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(10),
      child: isTablet
          ? table
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 870),
                child: table,
              ),
            ),
    );
  }
}

// bottom nav item
Widget _navItem(IconData icon, String label, {required VoidCallback onPressed}) {
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
