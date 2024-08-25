import 'package:fluffychat/pages/chat_list/chat_list.dart';
import 'package:fluffychat/pages/home/contacts.dart';
import 'package:fluffychat/pages/settings/settings.dart';
import 'package:fluffychat/pages/settings/settings_view.dart';
import 'package:flutter/material.dart';

class HomeTabsWidget extends StatefulWidget {
  const HomeTabsWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomeTabsState();
}

class HomeTabsState extends State<HomeTabsWidget> {
  int currentTab = 0;

  List<Widget> tabs = [
    // TODO: implement contact list
    ContactList(contacts: []),
    ChatList(activeChat: "1"),
    SettingsView(SettingsController())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        type: BottomNavigationBarType.fixed,
        onTap: (int newTab) {
          setState(() {
            currentTab = newTab;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: 'Contacts', icon: Icon(Icons.contacts)),
          BottomNavigationBarItem(label: 'Chat', icon: Icon(Icons.chat)),
          BottomNavigationBarItem(
              label: 'Account', icon: Icon(Icons.account_circle))
        ],
      ),
    );
  }
}
