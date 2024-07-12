import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';

class SignalService {
  final SignalProtocolStore store;
  final SessionBuilder sessionBuilder;
  final SessionCipher sessionCipher;

  SignalService(this.store, this.sessionBuilder, this.sessionCipher);

  static Future<SignalService> create() async {
    final identityKeyPair = generateIdentityKeyPair();
    final registrationId = generateRegistrationId(false);

    final store = InMemorySignalProtocolStore(identityKeyPair, registrationId);
    final address = SignalProtocolAddress('recipient', 1);

    final sessionBuilder = SessionBuilder(store, store, store, store, address);
    final sessionCipher = SessionCipher(store, store, store, store, address);

    return SignalService(store, sessionBuilder, sessionCipher);
  }

  Future<String> encryptMessage(String plaintext) async {
    final ciphertext = await sessionCipher.encrypt(Uint8List.fromList(utf8.encode(plaintext)));
    return base64.encode(ciphertext.serialize());
  }

  Future<void> sendMessage(String from, String to, String message) async {
    final encryptedMessage = await encryptMessage(message);
    await http.post(
      Uri.parse('http://localhost:3000/send'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'from': from,
        'to': to,
        'message': encryptedMessage,
      }),
    );
  }
}
