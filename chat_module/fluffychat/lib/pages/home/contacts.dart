import 'package:flutter/material.dart';
import 'package:fluffychat/widgets/avatar.dart';

class Contact {
  final String name;
  final Uri? avatarUrl;
  final String userId;

  Contact(this.avatarUrl, this.userId, {required this.name});
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;

  const ContactList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, i) {
        final contact = contacts[i];
        return ListTile(
          leading: Avatar(
            name: contact.name,
            mxContent: contact.avatarUrl,
            presenceUserId: contact.userId,
          ),
          title: Text(contact.name),
          subtitle: Text(contact.userId),
        );
      },
    );
  }
}
