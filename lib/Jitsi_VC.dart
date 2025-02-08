import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
class JitsiMeetingScreen extends StatefulWidget {
  @override
  _JitsiMeetingScreenState createState() => _JitsiMeetingScreenState();
}

class _JitsiMeetingScreenState extends State<JitsiMeetingScreen> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  void _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions(
        room: _roomController.text, // Required, unique room name and 
      )
        ..userDisplayName = _nameController.text
        ..audioMuted = false
        ..videoMuted = false;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jitsi Meeting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _roomController,
              decoration: InputDecoration(
                labelText: "Room Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinMeeting,
              child: Text("Join Meeting"),
            ),
          ],
        ),
      ),
    );
  }
}

