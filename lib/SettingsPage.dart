import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Game Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildSettingItem(
              title: 'Sound',
              subtitle: 'Enable or disable game sound',
              trailing: Switch(
                value: true, // Replace with your actual sound setting value
                onChanged: (value) {
                  // Implement logic to update sound setting
                },
              ),
            ),
            _buildSettingItem(
              title: 'Notifications',
              subtitle: 'Enable or disable game notifications',
              trailing: Switch(
                value: false, // Replace with your actual notifications setting value
                onChanged: (value) {
                  // Implement logic to update notifications setting
                },
              ),
            ),
            // Add more setting items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({required String title, required String subtitle, required Widget trailing}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: () {
        // Implement the logic for handling setting item tap
        // You can open a settings detail screen or perform other actions
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}
