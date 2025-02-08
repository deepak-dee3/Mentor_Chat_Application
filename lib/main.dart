import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitsi_meet/jitsi_meet.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FirebaseAuth.instance.currentUser != null
          ? ChatScreen()
          : LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginOrRegister(bool isLogin) async {
    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    } catch (e) {
      print(e); // Show error message to users
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _loginOrRegister(true),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => _loginOrRegister(false),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _messageController = TextEditingController();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': _messageController.text,
        'sender': _auth.currentUser!.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
       
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
  title: ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [Colors.black, Colors.blue],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(bounds),
    child: Text(
      'Mentor Chat',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white, // Set a default color
      ),
    ),
  ),
  //backgroundColor: Colors.blueGrey, // Set your AppBar background color
),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final text = message['text'];
                    final sender = message['sender'];
                    final timestamp = message['timestamp'] != null
        ? (message['timestamp'] as Timestamp).toDate()
        : null; // Ensure timestamp is available
    final time = timestamp != null
        ? "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}"
        : "N/A"; // Format the time
                    final isMe = sender == _auth.currentUser!.email;
                    return Container(
                      
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                            child: GestureDetector(
                              onLongPress: ()
                              {
                                print('hello');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                        color: isMe ? const Color.fromARGB(255, 209, 222, 232) : Colors.blue,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20)), // Rounded corners
                                      ),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                                  
                                  tileColor: Colors.transparent,
                                  title: Text(
                                    text,
                                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isMe ? Colors.blue : Colors.black,
                                    ),
                                  ),
                                 
                                  subtitle: Row(
                                                mainAxisAlignment: isMe
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  Text(sender, textAlign: isMe ? TextAlign.end : TextAlign.start,),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    time,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
         Container(
              decoration: BoxDecoration(
               
                color: Colors.transparent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
              ),
              child: Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10,left: 20,right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      
                      decoration: BoxDecoration(
                        boxShadow: [
                          
                          BoxShadow(color: Colors.grey,blurRadius: 0.5,spreadRadius: 1.4),
                           BoxShadow(color: Colors.grey,blurRadius: 0.5,spreadRadius: 1.4)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        
                        controller: _messageController,
                        decoration: InputDecoration(hintText: 'Enter message...',hintStyle: TextStyle(color: Colors.grey),border: InputBorder.none,contentPadding: EdgeInsets.only(left: 10)),
                        
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 22,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.send,color: Colors.white,),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


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
        room: _roomController.text, // Required, unique room name
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


// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: EmptyScreen(),
//     );
//   }
// }

// class EmptyScreen extends StatelessWidget {
//   // Function to send a message via WhatsApp
//   void launchWhatsApp({@required number , @required message}) async{

//     String url = "whatsapp://send?phone=$number&text=$message";

//     await canLaunchUrl(url) ? launch(url) : print('not open');

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WhatsApp Message'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//            launchWhatsApp(number: "+918870853143", message: "hello");
//           },
//           child: Text('Send Message to WhatsApp'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: EmptyScreen(),
//     );
//   }
// }

// class EmptyScreen extends StatelessWidget {
//   // Function to send a message via WhatsApp
//   void launchWhatsApp({required String number, required String message}) async {
//     final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$number&text=$message");

//     if (await canLaunchUrl(whatsappUri)) {
//       await launchUrl(whatsappUri);
//     } else {
//       // Display a snackbar if WhatsApp is not installed
//       print("WhatsApp not installed or cannot open URL");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WhatsApp Message'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             launchWhatsApp(number: "+918925691410", message: "Hello! This is a test message.");
//           },
//           child: Text('Send Message to WhatsApp'),
//         ),
//       ),
//     );
//   }
// }
