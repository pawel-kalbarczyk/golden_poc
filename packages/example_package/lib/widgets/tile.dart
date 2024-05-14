import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.title, required this.showError});
  final bool showError;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // width: 40,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: showError ? Colors.redAccent : Colors.greenAccent, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 12),
          const Icon(Icons.calendar_month, color: Colors.white, size: 80),
          const SizedBox(height: 8),
          const Text('Subtitle text', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.sunny),
              SizedBox(width: 4),
              Text('Third text'),
            ],
          ),
        ],
      ),
    );
  }
}
