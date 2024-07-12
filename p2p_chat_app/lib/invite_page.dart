import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvitePage extends StatelessWidget {
  final Function(String) onInviteCreated;
  final uuid = Uuid();

  InvitePage({required this.onInviteCreated});

  @override
  Widget build(BuildContext context) {
    final chatId = uuid.v4();
    final inviteUrl = 'https://example.com/invite/$chatId';

    return Scaffold(
      appBar: AppBar(
        title: Text('Invite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Invite URL:'),
            Text(
              inviteUrl,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            QrImage(
              data: inviteUrl,
              version: QrVersions.auto,
              size: 200.0,
            ),
            ElevatedButton(
              onPressed: () async {
                await http.post(
                  Uri.parse('http://localhost:3000/register'),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode({'username': chatId, 'pushToken': 'token'}), // Replace with actual push token
                );
                onInviteCreated(chatId);
                Navigator.pop(context);
              },
              child: Text('Create Invite'),
            ),
          ],
        ),
      ),
    );
  }
}
