import 'package:flutter/material.dart';
import 'signal_service.dart';

class ChatPage extends StatefulWidget {
  final String chatName;

  ChatPage({required this.chatName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  late SignalService _signalService;

  @override
  void initState() {
    super.initState();
    SignalService.create().then((service) {
      setState(() {
        _signalService = service;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatName),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text('${message["author"]}: ${message["text"]}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final messageText = _controller.text;
                    if (_signalService != null) {
                      await _signalService.sendMessage('You', widget.chatName, messageText);
                    }
                    setState(() {
                      messages.add({"author": "You", "text": messageText});
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
