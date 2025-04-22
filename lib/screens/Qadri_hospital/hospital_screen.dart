import 'package:flutter/material.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('روغتون'),
      ),
      body: const Center(
        child: Text(
          'Details about روغتون',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
