
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class EmptyScreen extends StatelessWidget {
  // Function to send a message via WhatsApp
  void launchWhatsApp({required String number, required String message}) async {
    final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$number&text=$message");

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      // Display a snackbar if WhatsApp is not installed
      print("WhatsApp not installed or cannot open URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Message'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchWhatsApp(number: "+918925691410", message: "Hello! This is a test message.");
          },
          child: Text('Send Message to WhatsApp'),
        ),
      ),
    );
  }
}
