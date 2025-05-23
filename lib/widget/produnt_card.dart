import 'package:flutter/material.dart';
import 'colors.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String price;
  final VoidCallback onPressed;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: const Color(0xFFF5F5F5),
            child: Center(
              child: Image.asset(
                imagePath,
                height: 190, // Adjust the height as needed
                width: 100, // Take the full width
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 11.0, color: Colors.grey),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
