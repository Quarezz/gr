import 'package:fluffychat/pages/home/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluffychat/widgets/avatar.dart';
import 'package:matrix/matrix_api_lite/generated/model.dart';

import '../../widgets/matrix.dart';
import '../../widgets/mxc_image.dart';

class ContactList extends StatelessWidget {
  final ContactsController controller = ContactsController();

  ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Контакти'),
      ),
      body: FutureBuilder<List<Contact>>(
        /// Fetch contacts
        future: controller.fetchContacts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No contacts found.'));
          }
          /// Sort fetched contacts
          final contacts = snapshot.data!;
          /// Present contacts on the UI
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: ClipOval(
                  child: SizedBox(
                    width: 64.0, // Specify the width
                    height: 64.0, // Specify the height
                    child: Center(child: MxcImage(
                        key: Key(contact.userId),
                        uri: contact.avatarUrl,
                        fit: BoxFit.fill,
                        width: 64,
                        height: 64,
                        placeholder: (_) => Container(color: Colors.grey),
                        cacheKey: contact.userId.toString(),
                      )
                    ),
                  ),
                ),
                title: Text(contact.name),
                subtitle: Text(contact.userId),
                onTap: () {
                  // Handle contact tap, e.g., navigate to chat
                },
              );
            },
          );
        },
      ),
    );
  }
}
