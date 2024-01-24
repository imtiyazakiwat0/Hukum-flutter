import 'package:flutter/material.dart';

import 'Room.dart';

// void main() {
//   runApp(MaterialApp(
//     home: GameHomePage(),
//   ));
// }

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hukum Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Hukum Game!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomPage(),
                  ),
                );
              },
              child: Text('Create/Join Room'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation taps
          if (index == 0) {
            // Home tab pressed
          } else if (index == 1) {
            // Friends tab pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendsPage()),
            );
          } else if (index == 2) {
            // Settings tab pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
      ),
    );
  }
}

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Center(
        child: Text('Friends Page'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

// class RoomPage extends StatelessWidget {
//   final bool isCreator;
//
//   RoomPage({required this.isCreator});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isCreator ? 'Create Room' : 'Join Room'),
//       ),
//       body: Center(
//         child: Text(
//           isCreator ? 'You are the room creator' : 'You joined the room',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
