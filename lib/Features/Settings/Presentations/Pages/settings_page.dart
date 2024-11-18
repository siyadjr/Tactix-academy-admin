import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Web layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _buildSettingsSection(context, 'General', [
                      const SettingsItem(
                          title: 'Theme',
                          value: 'Light',
                          icon: Icons.color_lens),
                      const SettingsItem(
                          title: 'Language',
                          value: 'English',
                          icon: Icons.language),
                    ])),
                    const SizedBox(width: 32),
                    Expanded(
                        child: _buildSettingsSection(context, 'Account', [
                      const SettingsItem(
                          title: 'Email',
                          value: 'user@example.com',
                          icon: Icons.email),
                      const SettingsItem(
                          title: 'Password',
                          value: '********',
                          icon: Icons.lock),
                    ])),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSettingsSection(context, 'General', [
                      const SettingsItem(
                          title: 'Theme',
                          value: 'Light',
                          icon: Icons.color_lens),
                      const SettingsItem(
                          title: 'Language',
                          value: 'English',
                          icon: Icons.language),
                    ]),
                    const SizedBox(height: 16),
                    _buildSettingsSection(context, 'Account', [
                      const SettingsItem(
                          title: 'Email',
                          value: 'user@example.com',
                          icon: Icons.email),
                      const SettingsItem(
                          title: 'Password',
                          value: '********',
                          icon: Icons.lock),
                    ]),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, String title, List<SettingsItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          for (var item in items) item,
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SettingsItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey[300]),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Add action here for when value is tapped
            },
            child: Text(
              value,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
