import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/Licence%20Requests/Presentations/Pages/request_details.dart';

class RequestLists extends StatelessWidget {
  const RequestLists({super.key});

  Stream<List<Map<String, dynamic>>> fetchPendingManagers() {
    return FirebaseFirestore.instance
        .collection('Managers')
        .where('license status', isEqualTo: 'pending')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            if (!data.containsKey('name') || !data.containsKey('email')) {
              debugPrint('Missing fields in document: ${doc.id}');
            }
            return {
              'name': data['name'] ?? 'No Name',
              'email': data['email'] ?? 'No Email',
              'id': doc.id,
              'licenseUrl': data['licenseUrl'] ?? '',
              'license status': data['license status'] ?? ''
            };
          }).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Pending Requests"),
        backgroundColor: textColor,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchPendingManagers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            debugPrint("Error in StreamBuilder: ${snapshot.error}");
            return const Center(
              child: Text(
                'An error occurred. Please try again later.',
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty, color: Colors.grey, size: 60),
                  SizedBox(height: 16),
                  Text(
                    'No pending requests found.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            );
          }

          final managers = snapshot.data!;
          return ListView.builder(
            itemCount: managers.length,
            itemBuilder: (context, index) {
              final manager = managers[index];
              return Card(
                color: Colors.grey[850],
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    manager['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    manager['email'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      log(manager['id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => RequestDetails(manager: manager),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Details"),
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
