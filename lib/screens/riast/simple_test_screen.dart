import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SimpleTestScreen extends StatelessWidget {
  const SimpleTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Test')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Kandahar University')
            .doc('kdru')
            .collection('administrativeUnits')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  const Text('Check console for details'),
                ],
              ),
            );
          }
          
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No documents found'),
                  SizedBox(height: 16),
                  Text('Path: Kandahar University/kdru/administrativeUnits'),
                ],
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Document ID: ${docs[index].id}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Name: ${data['name'] ?? 'No name'}'),
                      Text('Mission: ${data['Mission'] ?? 'No mission'}'),
                      Text('Vision: ${data['Vision'] ?? 'No vision'}'),
                      Text('Director: ${data['director'] ?? 'No director'}'),
                      Text('Contact: ${data['contactInfo'] ?? 'No contact'}'),
                      const SizedBox(height: 8),
                      Text('All Keys: ${data.keys.toList()}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
