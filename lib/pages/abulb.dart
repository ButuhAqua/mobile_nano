import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class ABulbScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

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
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lightbulb_outline, color: Colors.black),
              label: const Text('Pikolite', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Product A-Bulb',
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // ===== Gambar + Spesifikasi (responsive) =====
            LayoutBuilder(
              builder: (context, c) {
                final useRow = isTablet && c.maxWidth >= 680;

                final image = Image.asset(
                  'assets/images/spekabulb1.png',
                  height: isTablet ? 220 : 170,
                );

                final specBox = _specBox();

                if (useRow) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 4, child: image),
                      const SizedBox(width: 16),
                      Expanded(flex: 5, child: specBox),
                    ],
                  );
                }
                // Smartphone: gambar di atas, spesifikasi di bawah
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    const SizedBox(height: 12),
                    specBox,
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            // Tabel: bisa di-scroll horizontal di smartphone
            _buildTable(isTablet),

            const SizedBox(height: 30),

            Text(
              'Perbandingan:',
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // Perbandingan: Tablet 2 kolom, Smartphone 1 kolom (stack)
            LayoutBuilder(
              builder: (context, constraints) {
                final twoCols = isTablet && constraints.maxWidth >= 680;

                final left = Image.asset('assets/images/nanobulbspek.png');
                final right = Image.asset('assets/images/productkomp.png');

                if (twoCols) {
                  return Row(
                    children: [
                      Expanded(child: left),
                      const SizedBox(width: 10),
                      Expanded(child: right),
                    ],
                  );
                }
                return Column(
                  children: [
                    left,
                    const SizedBox(height: 10),
                    right,
                  ],
                );
              },
            ),

            const SizedBox(height: 24),
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

  // ====== Widgets bantu ======
  Widget _specBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('SPESIFIKASI',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
          SizedBox(height: 8),
          _SpecLine(title: 'Tahan Sampai:', value: '15.000 Jam'),
          _SpecLine(title: 'Fitting:', value: 'E27'),
          _SpecLine(title: 'Hemat Energi:', value: '90%'),
          _SpecLine(title: 'Lumen:', value: '100lm/Watt'),
          _SpecLine(title: 'Tegangan:', value: '110~240V'),
          _SpecLine(title: 'CRI:', value: '>80Ra'),
        ],
      ),
    );
  }

  Widget _buildTable(bool isTablet) {
    final headerStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
    final rows = [
      ['3 Watt',  '115mm',  '60mm',   '3000K', '6500K', 'Rp 12.900'],
      ['5 Watt',  '115mm',  '60mm',   '3000K', '6500K', 'Rp 14.900'],
      ['7 Watt',  '115mm',  '55mm',   '3000K', '6500K', 'Rp 16.900'],
      ['9 Watt',  '125.5mm','65mm',   '3000K', '6500K', 'Rp 18.900'],
      ['12 Watt', '125.5mm','65mm',   '3000K', '6500K', 'Rp 19.900'],
      ['15 Watt', '137.5mm','69.8mm', '3000K', '6500K', 'Rp 25.900'],
    ];

    final table = Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: isTablet
          ? {for (int i = 0; i < 6; i++) i: const FlexColumnWidth()}
          : const {
              0: FixedColumnWidth(110),
              1: FixedColumnWidth(110),
              2: FixedColumnWidth(120),
              3: FixedColumnWidth(130),
              4: FixedColumnWidth(140),
              5: FixedColumnWidth(110),
            },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: [
            for (var header in const [
              'Watt', 'Tinggi', 'Diameter', 'Warm White', 'Cool Day Light', 'Harga'
            ])
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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

// Baris spesifikasi kecil
class _SpecLine extends StatelessWidget {
  final String title;
  final String value;
  const _SpecLine({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
