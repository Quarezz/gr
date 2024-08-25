import 'package:flutter/material.dart';

class HomeTabsWidget extends StatefulWidget {
  const HomeTabsWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomeTabsState();
}

class HomeTabsState extends State<HomeTabsWidget> {
  int currentTab = 0;

  // TODO:
  // List with widgets to change using tabs
  // Contacts (in progress)
  // ChatList
  // SettingsView

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
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
