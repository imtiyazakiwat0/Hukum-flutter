import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: ListView(
        children: [
          Text('There are no friends yet '),
          _buildFriendItem('...')
          // Add more friend items as needed
        ],
      ),
    );
  }

  Widget _buildFriendItem(String friendName) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(friendName),
        // You can add more details about the friend, such as status or profile image
        // based on your requirements
        // trailing: Icon(Icons.circle), // Example of adding an icon as a status indicator
        onTap: () {
          // Implement the logic for handling friend item tap
          // You can navigate to a friend's profile or perform other actions
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FriendsPage(),
  ));
}
