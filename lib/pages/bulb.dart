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
      backgroundColor: const Color(0xFF061F3D),
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
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lightbulb, color: Colors.black),
              label: const Text('Nanolite', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              'Product Bulb',
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            // ====== HERO: Image + Spec (tablet side-by-side, phone stacked) ======
            LayoutBuilder(
              builder: (context, c) {
                final bool sideBySide = isTablet && c.maxWidth >= 680;

                final img = Center(
                  child: Image.asset(
                    'assets/images/spekbulb.png',
                    width: isTablet ? 320 : 220,
                    fit: BoxFit.contain,
                  ),
                );

                final spec = _SpecCard();

                if (sideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: img),
                      const SizedBox(width: 16),
                      Expanded(child: spec),
                    ],
                  );
                }
                // Phone: image then spec below (lebih rapi)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    img,
                    const SizedBox(height: 16),
                    spec,
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // ====== TABLE: phone can scroll horizontally ======
            _buildTable(isTablet),

            const SizedBox(height: 30),

            // ====== PERBANDINGAN ======
            Text(
              'Perbandingan:',
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            LayoutBuilder(
              builder: (context, constraints) {
                final bool twoCols = isTablet && constraints.maxWidth >= 680;

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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: left),
                      Expanded(child: right),
                    ],
                  );
                }
                // Phone: satu kolom, slide ke bawah
                return Column(
                  children: [
                    left,
                    right,
                  ],
                );
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

  // ===== Table =====
  Widget _buildTable(bool isTablet) {
    final headerStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
    final rows = [
      ['5 Watt', '840ml',  '115mm',  '60mm',   '100', '3000K', '6500K', 'Rp 30.900'],
      ['7 Watt', '600ml',  '105mm',  '55mm',   '100', '3000K', '6500K', 'Rp 23.900'],
      ['9 Watt', '1080ml', '110mm',  '65mm',   '100', '3000K', '6500K', 'Rp 35.900'],
      ['12 Watt','1440ml', '125.5mm','55mm',   '100', '3000K', '6500K', 'Rp 42.900'],
      ['15 Watt','1800ml', '137.5mm','69.8mm', '100', '3000K', '6500K', 'Rp 50.900'],
    ];

    final table = Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: isTablet
          ? {for (int i = 0; i < 8; i++) i: const FlexColumnWidth()}
          : const {
              0: FixedColumnWidth(110),
              1: FixedColumnWidth(110),
              2: FixedColumnWidth(110),
              3: FixedColumnWidth(120),
              4: FixedColumnWidth(90),
              5: FixedColumnWidth(120),
              6: FixedColumnWidth(120),
              7: FixedColumnWidth(110),
            },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: [
            for (var header in const [
              'Watt', 'Lumen', 'Tinggi', 'Diameter', 'Isi/Dus', 'Warm White', 'Cool Day', 'Harga'
            ])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Center(child: Text(header, style: headerStyle)),
              )
          ],
        ),
        ...rows.map((row) {
          return TableRow(
            decoration: const BoxDecoration(color: Color(0xFF061F3D)),
            children: row.map((cell) {
              final isColor = cell == '3000K' || cell == '6500K';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Center(
                  child: Text(
                    cell,
                    style: TextStyle(
                      color: isColor
                          ? (cell == '3000K' ? Colors.yellow[700] : Colors.blue[300])
                          : Colors.white,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
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

  // ===== Bottom nav item =====
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

// ===== Spec Card (sesuai gambar) =====
class _SpecCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget header = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Text(
        'Spesifikasi',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );

    TextSpan line(String label, String value) => TextSpan(
      children: [
        TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
        TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1C2A39))),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E243C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          header,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 14, height: 1.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(children: [
                    TextSpan(text: 'Tahan Sampai: ', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                    TextSpan(text: '25.000 Jam', style: TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                  SizedBox(height: 6),
                  RichText(text: TextSpan(children: [
                    TextSpan(text: 'Fitting: ', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                    TextSpan(text: 'E27', style: TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                  SizedBox(height: 6),
                  RichText(text: TextSpan(children: [
                    TextSpan(text: 'Hemat Energi: ', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                    TextSpan(text: '90%', style: TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                  SizedBox(height: 6),
                  RichText(text: TextSpan(children: [
                    TextSpan(text: 'LED: ', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                    TextSpan(text: 'Samsung', style: TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                  SizedBox(height: 6),
                  RichText(text: TextSpan(children: [
                    TextSpan(text: 'Tegangan: ', style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87)),
                    TextSpan(text: '110–240V', style: TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
