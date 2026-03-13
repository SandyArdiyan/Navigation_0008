import 'package:flutter/material.dart';
import 'package:navigasi/page/main_layout.dart';
import '../mainui/home.dart';
class DetailOrderPage extends StatelessWidget {
  final String makanan;
  final String minuman;
  final String jumlahMakanan;
  final String jumlahMinuman;
  final int totalHarga;

  const DetailOrderPage({
    super.key,
    required this.makanan,
    required this.minuman,
    required this.jumlahMakanan,
    required this.jumlahMinuman,
    required this.totalHarga,
  });

  Widget _buildReceiptRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal
                  ? MainLayout.primaryColor
                  : MainLayout.textSubtitleColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 15,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.bold,
              color: isTotal
                  ? MainLayout.primaryColor
                  : MainLayout.textTitleColor,
            ),
          ),
        ],
      ),
    );
  }

  String formatHarga(int harga) {
    return harga.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Order Summary",
      showAppBar: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            // Icon sukses
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 80,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Order Successful!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: MainLayout.textTitleColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Here are your order details",
              style: TextStyle(
                fontSize: 16,
                color: MainLayout.textSubtitleColor,
              ),
            ),

            const SizedBox(height: 40),

            // Receipt
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "RECEIPT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: MainLayout.labelColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Divider(),

                  const SizedBox(height: 16),

                  const Text(
                    "Food",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MainLayout.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildReceiptRow("Menu", makanan),
                  _buildReceiptRow("Quantity", jumlahMakanan),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  const Text(
                    "Drink",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildReceiptRow("Menu", minuman),
                  _buildReceiptRow("Quantity", jumlahMinuman),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  _buildReceiptRow(
                    "Total Price",
                    "Rp ${formatHarga(totalHarga)}",
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Button back
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: MainLayout.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}