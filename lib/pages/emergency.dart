import 'package:flutter/material.dart';

import 'create_sales_order.dart';
import 'home.dart';
import 'profile.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isTablet = constraints.maxWidth >= 600;

        // layout metrics
        final double padding = isTablet ? 24 : 16;
        final double imageSize = isTablet ? 260 : 220; // ↑ smartphone dibuat lebih besar & jadi 220
        final double compareImageHeight = isTablet ? 220 : 180;
        final double titleFontSize = isTablet ? 22 : 16;
        final double specFontSize = isTablet ? 16 : 13;

        return Scaffold(
          backgroundColor: const Color(0xFF0B2240),
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
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
                  label: const Text('Nanolite'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Product Emergency',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // ========== HERO: Gambar + Spesifikasi (responsive) ==========
                LayoutBuilder(
                  builder: (context, c) {
                    final bool sideBySide = isTablet && c.maxWidth >= 680;

                    final image = Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF162B4C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      // Center supaya gambar benar2 di tengah di smartphone
                      child: Center(
                        child: Image.asset(
                          'assets/images/emergency.jpg',
                          height: imageSize,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );

                    final spec = Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF162B4C),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Text(
                              'SPESIFIKASI',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildSpecBox(
                            [
                              'Tahan Sampai: Hingga 4 Jam',
                              'Baterai: 2200mAh Lithium',
                              'Hemat Energi: 90%',
                              'Arus: AC/DC',
                              'Tegangan: 100–240V',
                            ],
                            specFontSize,
                          ),
                        ],
                      ),
                    );

                    if (sideBySide) {
                      // Tablet: gambar kiri, spesifikasi kanan
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 5, child: image),
                          const SizedBox(width: 16),
                          Expanded(flex: 6, child: spec),
                        ],
                      );
                    }

                    // Smartphone: gambar di atas (lebih besar & center), spesifikasi di bawah
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image,
                        const SizedBox(height: 12),
                        spec,
                      ],
                    );
                  },
                ),

                const SizedBox(height: 28),

                // ========== TABEL (HP bisa scroll horizontal) ==========
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildSpecTable(specFontSize, isTablet),
                ),

                const SizedBox(height: 28),

                // ========== PERBANDINGAN ==========
                Text(
                  'Perbandingan:',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                LayoutBuilder(
                  builder: (context, c) {
                    final bool twoCols = isTablet && c.maxWidth >= 680;

                    final left = _buildCompareImage(
                        'assets/images/emerspek.jpg', 'NANOLITE', compareImageHeight);
                    final right = _buildCompareImage(
                        'assets/images/emerkomp.jpg', 'PRODUK LAIN', compareImageHeight);

                    if (twoCols) {
                      // Tablet: 2 kolom
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: left),
                          const SizedBox(width: 12),
                          Expanded(child: right),
                        ],
                      );
                    }
                    // Smartphone: 1 kolom (stack ke bawah)
                    return Column(
                      children: [
                        left,
                        const SizedBox(height: 12),
                        right,
                      ],
                    );
                  },
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),

          // ========== Bottom Navigation ==========
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
      },
    );
  }

  // ================= Helpers =================

  Widget _buildSpecBox(List<String> specs, double fontSize) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: specs
            .map((spec) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '• $spec',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildSpecTable(double fontSize, bool isTablet) {
    final rows = [
      ['10 Watt', 'AC 1000lm / DC 700lm', '70mm x 141mm', '80', '6500K', 'Cahaya Putih Kebiruan'],
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: isTablet
            ? const {
                0: FixedColumnWidth(120),
                1: FixedColumnWidth(210),
                2: FixedColumnWidth(190),
                3: FixedColumnWidth(90),
                4: FixedColumnWidth(90),
                5: FixedColumnWidth(200),
              }
            : const {
                0: FixedColumnWidth(110),
                1: FixedColumnWidth(200),
                2: FixedColumnWidth(180),
                3: FixedColumnWidth(70),
                4: FixedColumnWidth(80),
                5: FixedColumnWidth(200),
              },
        children: [
          _buildTableRow(
            ['Varian Watt', 'Lumen', 'Dimensi (Tinggi x Diameter)', 'Isi/Dus', 'Warna', 'Keterangan'],
            isHeader: true,
            fontSize: fontSize,
          ),
          for (var row in rows) _buildTableRow(row, fontSize: fontSize),
        ],
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false, required double fontSize}) {
    return TableRow(
      decoration: BoxDecoration(color: isHeader ? const Color(0xFF0B2240) : Colors.white),
      children: cells.map((text) {
        final bool isColorCell = text == '6500K';
        return Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          color: isColorCell ? Colors.lightBlueAccent : null,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: (isHeader || isColorCell) ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Colors.white : Colors.black87,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCompareImage(String imagePath, String title, double imageHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF162B4C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(imagePath, height: imageHeight),
        ),
      ],
    );
  }

  Widget _navItem(IconData icon, String label, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
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
