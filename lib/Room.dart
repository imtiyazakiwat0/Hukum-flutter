import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//   }
//
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hukum Card Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'NotoSans',
      ),
      home: RoomPage(),
    );
  }
}

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final DatabaseReference _roomsReference = FirebaseDatabase.instance.reference().child('rooms');

  String _roomCode = '';
  String _playerName = '';
  int? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Hukum Card Game - Room')),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'Welcome to Hukum Card Game!',
              //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              // ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => _playerName = value,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              DropdownButton<int>(
                value: _selectedPosition,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedPosition = newValue;
                  });
                },
                items: [1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('Player $value', style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
                underline: Container(
                  height: 2,
                  color: Colors.white,
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createRoom,
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text('Create Room', style: TextStyle(color: Colors.blueAccent)),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) => _roomCode = value,
                decoration: InputDecoration(
                  labelText: 'Enter Room Code',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _joinRoom(_roomCode),
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text('Join Room', style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createRoom() {
    _roomCode = generateRoomCode();
    DatabaseReference roomReference = _roomsReference.child(_roomCode);

    roomReference.set({
      'creator': _playerName,
    });

    if (_selectedPosition != null) {
      String playerId = roomReference.child('players').child('player$_selectedPosition').push().key ?? '';

      roomReference.child('players/player$_selectedPosition/$playerId').set(_playerName);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LobbyPage(_roomCode, _playerName, _selectedPosition!),
      ),
    );
  }

  Future<void> _joinRoom(String roomCode) async {
    DatabaseReference roomReference = _roomsReference.child(roomCode);

    DatabaseEvent roomEvent = await roomReference.once();

    if (roomEvent.snapshot.value != null) {
      Map<dynamic, dynamic>? roomData = roomEvent.snapshot.value as Map<dynamic, dynamic>?;

      if (roomData != null) {
        if (_selectedPosition != null) {
          String playerId = roomReference.child('players').child('player$_selectedPosition').push().key ?? '';

          roomReference.child('players/player$_selectedPosition/$playerId').set(_playerName);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LobbyPage(roomCode, _playerName, _selectedPosition!),
            ),
          );
        } else {
          // Show an error message or handle accordingly if the position is not selected
        }
      }
    } else {
      // Room does not exist, handle accordingly
      // You might want to show a message or navigate to a different screen
    }
  }

  String generateRoomCode() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(List.generate(6, (index) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }
}

class LobbyPage extends StatefulWidget {
  final String roomCode;
  final String playerName;
  final int playerPosition;

  LobbyPage(this.roomCode, this.playerName, this.playerPosition);

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final DatabaseReference _roomReference = FirebaseDatabase.instance.reference().child('rooms');

  List<String> players = [];
  int _playerPosition = 0;

  @override
  void initState() {
    super.initState();
    _loadPlayerPosition();
    _loadPlayers();
  }

  void _loadPlayerPosition() {
    _roomReference.child(widget.roomCode).child('players').once().then((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? playersData = event.snapshot.value as Map<dynamic, dynamic>?;

        if (playersData != null) {
          playersData.forEach((position, playerName) {
            if (playerName == widget.playerName) {
              setState(() {
                _playerPosition = int.parse(position.replaceAll('player', ''));
              });
              return;
            }
          });
        }
      }
    });
  }

  void _loadPlayers() {
    _roomReference.child(widget.roomCode).child('players').onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? playersData = event.snapshot.value as Map<dynamic, dynamic>?;

        if (playersData != null) {
          List<String> playerList = [];
          playersData.forEach((position, playerName) {
            String cleanedName = playerName.toString().split(':').last.trim();
            // Remove the last character
            if (cleanedName.isNotEmpty) {
              cleanedName = cleanedName.substring(0, cleanedName.length - 1);
            }
            playerList.add('Player ${int.parse(position.replaceAll('player', ''))}: $cleanedName');
          });

          setState(() {
            players = playerList;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Lobby - ${widget.roomCode}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Room ${widget.roomCode}, ${widget.playerName}!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Text(
            //   'Your position: Player $_playerPosition',
            //   style: TextStyle(fontSize: 16),
            // ),
            SizedBox(height: 20),
            Text('Players in the room:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            if (players.isNotEmpty)
              Column(
                children: players.map((player) => Text(player, style: TextStyle(fontSize: 16))).toList(),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to start the game
                // You might want to navigate to a game screen
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }
}
