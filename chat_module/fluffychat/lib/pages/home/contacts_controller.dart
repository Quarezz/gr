import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix_api_lite/generated/model.dart';

import '../../widgets/matrix.dart';

class Contact {
  final String name;
  final Uri? avatarUrl;
  final String userId;

  Contact(this.avatarUrl, this.userId, {required this.name});
}

class ContactsController {
  Future<List<Contact>> fetchContacts(BuildContext context) async {
    final matrixClient = Matrix.of(context).client;
    /// Fetch rooms (conversations) the user has joined
    final rooms = matrixClient.rooms;
    /// Extract contacts from the rooms
    final contacts = <Contact>[];
    for (final room in rooms) {
      final members = await room.requestParticipants();
      for (final member in members) {
        /// Get only those who are currently in the room and filter ourself out
        if (member.membership == Membership.join && member.id != matrixClient.userID) {
          contacts.add(Contact(
            member.avatarUrl != null
                ? Uri.parse(member.avatarUrl!.toString())
                : null,
            member.id,
            name: member.displayName ?? member.id,
          ));
        }
      }
    }
    /// Remove any duplicates
    final uniqueContacts = {
      for (final contact in contacts)
        contact.userId: contact
    }.values.toList();

    final sortedContacts = uniqueContacts.sorted((a, b) => a.name.compareTo(b.name));
    return sortedContacts;
  }
}