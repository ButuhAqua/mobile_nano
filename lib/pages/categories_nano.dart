import 'package:flutter/material.dart';

import 'bulb.dart' show BulbScreen;
import 'capsule.dart' show CapsuleScreen;
import 'create_sales_order.dart' show CreateSalesOrderScreen;
import 'downlight_round.dart' show DownlightRoundPage;
import 'downlight_square.dart' show DownlightSquarePage; // batasi simbol
import 'emergency.dart' show EmergencyScreen;
import 'floodlight.dart' show FloodLightPage;           // Flood Light
import 'home.dart' show HomeScreen;
import 'ls50m.dart' show LightStrip50MPage;            // ⬅️ Light Strip 50M
import 'lsindoor.dart' show IndoorPage;                // Light Strip Indoor
import 'lsoutdoor.dart' show OutdoorPage;              // Light Strip Outdoor
import 'multipack.dart' show MultipackPage;
import 'powersupply.dart' show PowerSupplyPage;        // Power Supply
import 'profile.dart' show ProfileScreen;
import 'sl711.dart' show StreetLight711Page;           // Street Light 711
import 'sl712.dart' show StreetLight712Page;           // Street Light 712
import 't8tubelight.dart' show T8TubeLightPage;

class CategoriesNanoScreen extends StatelessWidget {
  const CategoriesNanoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061F3D),
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.shopping_basket, color: Colors.black),
            SizedBox(width: 8),
            Text('Categories', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isTablet = constraints.maxWidth >= 600;
            final int crossAxisCount = isTablet ? 3 : 2;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 14,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) =>
                          _buildCategoryCard(context, index, isTablet),
                    ),
                  ),
                ],
              ),
            );
          },
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

  Widget _buildCategoryCard(BuildContext context, int index, bool isTablet) {
    final List<String> categoryNames = [
      'Bulb', 'Capsule', 'Emergency', 'Multipack', 'Downlight Round', 'Downlight Square',
      'Power Supply', 'T8-Tube Light', 'Flood Light', 'Street Light 712', 'Street Light 711',
      'Light Strip 50M', 'Light Strip Indoor', 'Light Strip Outdoor'
    ];

    final List<String> imagePaths = [
      'assets/images/bulb.png', 'assets/images/capsule.png', 'assets/images/emergency.png',
      'assets/images/MULTIPAK1.png', 'assets/images/round.png', 'assets/images/square.png',
      'assets/images/powersuplay1.png', 'assets/images/t81.png', 'assets/images/FloodLight00011.png',
      'assets/images/SL712.png', 'assets/images/SL711.png', 'assets/images/50m1.png',
      'assets/images/indoor1.png', 'assets/images/outdoor1.png'
    ];

    final double imageSize = isTablet ? 100 : 70;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => BulbScreen()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => EmergencyScreen()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MultipackPage()));
        } else if (index == 4) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DownlightRoundPage()));
        } else if (index == 5) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => DownlightSquarePage()));
        } else if (index == 6) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => PowerSupplyPage()));
        } else if (index == 7) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => T8TubeLightPage()));
        } else if (index == 8) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FloodLightPage()));
        } else if (index == 9) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StreetLight712Page()));
        } else if (index == 10) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => StreetLight711Page()));
        } else if (index == 11) {
          // ✅ Light Strip 50M -> ls50m.dart
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LightStrip50MPage()));
        } else if (index == 12) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const IndoorPage()));
        } else if (index == 13) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const OutdoorPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Halaman ${categoryNames[index]} belum tersedia')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF12355C),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePaths[index]),
                  // beberapa item butuh contain agar proporsi bagus
                  fit: (index == 3 || index == 4 || index == 5 || index == 6 ||
                        index == 7 || index == 8 || index == 9 || index == 10 ||
                        index == 11 || index == 12 || index == 13) // ← termasuk Light Strip 50M
                      ? BoxFit.contain
                      : BoxFit.cover,
                  alignment: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              categoryNames[index],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 16 : 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
