// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'crypto_service.dart';
import 'message_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: EncryptionScreen(),
      ),
    );
  }
}

class EncryptionScreen extends StatelessWidget {
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController decryptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final messageModel = Provider.of<MessageModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('NMIT Encryption App'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'End-to-End Encryption for SMS',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: recipientController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Recipient Number',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: messageController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Message',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final encryptedMessage = CryptoService.encryptMessage(
                    messageController.text,
                  );
                  messageModel.setMessage(
                    recipientController.text,
                    messageController.text,
                    encryptedMessage,
                  );
                },
                child: Text('Send Encrypted Message'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: decryptController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Encrypted Message',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final decryptedMessage = CryptoService.decryptMessage(
                    decryptController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Decrypted Message: $decryptedMessage'),
                    ),
                  );
                },
                child: Text('Decrypt Message'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              if (messageModel.encryptedMessage.isNotEmpty) ...[
                Divider(
                  color: Colors.grey[400],
                  thickness: 2.0,
                  height: 32.0,
                ),
                Text(
                  'Encrypted Message:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                Text(
                  messageModel.encryptedMessage,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.0),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
