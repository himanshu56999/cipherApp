// lib/message_model.dart
import 'package:flutter/foundation.dart';

class MessageModel extends ChangeNotifier {
  String recipientNumber = '';
  String originalMessage = '';
  String encryptedMessage = '';

  void setMessage(String recipient, String original, String encrypted) {
    recipientNumber = recipient;
    originalMessage = original;
    encryptedMessage = encrypted;
    notifyListeners();
  }
}
