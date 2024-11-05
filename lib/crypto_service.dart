// lib/crypto_service.dart
import 'package:encrypt/encrypt.dart';

class CryptoService {
  static final _key = Key.fromUtf8('my 32 length key................');
  static final _iv = IV.fromLength(16);

  static String encryptMessage(String message) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(message, iv: _iv);
    return encrypted.base64;
  }

  static String decryptMessage(String encryptedMessage) {
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decrypt64(encryptedMessage, iv: _iv);
    return decrypted;
  }
}
