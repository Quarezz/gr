import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/utils/client_manager.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'package:fluffychat/widgets/error_widget.dart';
import 'package:fluffychat/config/setting_keys.dart';
import 'package:fluffychat/utils/background_push.dart';
import 'package:fluffychat/widgets/fluffy_chat_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Secret app'),
            foregroundColor: Colors.white70,
            backgroundColor: Color.fromRGBO(23, 68, 89, 1)),
        body: Center(
          child: TextButton(
            onPressed: () {
              startFluffy(context);
            },
            child: const Text('Open Matrix client'),
          ),
        ));
  }

  startFluffy(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final store = await SharedPreferences.getInstance();
    final clients = await ClientManager.getClients(store: store);
    await startGui(clients, store, context);
  }

  /// Fetch the pincode for the applock and start the flutter engine.
  Future<void> startGui(List<Client> clients, SharedPreferences store,
      BuildContext context) async {
    // Fetch the pin for the applock if existing for mobile applications.
    String? pin;
    if (PlatformInfos.isMobile) {
      try {
        pin = await const FlutterSecureStorage()
            .read(key: SettingKeys.appLockKey);
      } catch (e, s) {
        Logs().d('Unable to read PIN from Secure storage', e, s);
      }
    }

    // Preload first client
    final firstClient = clients.firstOrNull;
    await firstClient?.roomsLoading;
    await firstClient?.accountDataLoading;

    ErrorWidget.builder = (details) => FluffyChatErrorWidget(details);

    ///runApp(FluffyChatApp(clients: clients, pincode: pin, store: store));

    /// TODO: rewrite to sync
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FluffyChatApp(clients: clients, pincode: pin, store: store)),
    );
  }
}
