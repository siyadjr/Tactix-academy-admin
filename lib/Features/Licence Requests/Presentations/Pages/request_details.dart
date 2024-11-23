import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RequestDetails extends StatelessWidget {
  final Map<String, dynamic> manager;

  const RequestDetails({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    log(manager['licenseUrl'] ?? 'No license URL available');

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          "${manager['name']}'s Details",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we're on a wide screen
          bool isWideScreen = constraints.maxWidth > 900;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: isWideScreen ? 1200 : 600),
                padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0),
                child: isWideScreen
                    ? _buildWideLayout(context)
                    : _buildNarrowLayout(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Manager Information
        Expanded(
          flex: 1,
          child: Card(
            color: const Color(0xFF2A2A2A),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Manager Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoCard(),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        // Right side - License Image
        Expanded(
          flex: 1,
          child: Card(
            color: const Color(0xFF2A2A2A),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "License Document",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildImageDisplay(manager['licenseUrl']),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: const Color(0xFF2A2A2A),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Manager Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoCard(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: const Color(0xFF2A2A2A),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "License Document",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildImageDisplay(manager['licenseUrl']),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          "Name",
          manager['name'],
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          "Email",
          manager['email'],
          icon: Icons.email,
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          "License Status",
          manager['license status'],
          icon: Icons.verified_user,
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String? value, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageDisplay(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: const Color(0xFF363636),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "No image available",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: kIsWeb
            ? Image.network(
                imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _errorPlaceholder();
                },
              )
            : Image.file(
                File(imageUrl),
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _errorPlaceholder();
                },
              ),
      ),
    );
  }

  Widget _errorPlaceholder() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF363636),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Failed to load image",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleAction(context, 'approve'),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("Approve"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleAction(context, 'reject'),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text("Reject"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleAction(BuildContext context, String action) async {
    String status = action == 'approve' ? "approved" : "rejected";

    try {
      await FirebaseFirestore.instance
          .collection('Managers')
          .doc(manager['id'])
          .update({'license status': status});
      log(status);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "License $status successfully!",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: action == 'approve' ? Colors.green : Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      log("Error updating Firestore: $e");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to $status license. Try again.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.grey[800],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}