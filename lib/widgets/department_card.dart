import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const DepartmentCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
