import 'package:flutter/material.dart';
import 'package:songplay/pages/settings_page.dart';  // Importă SettingsPage

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.music_note,
              size: 40,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          ListTile(
            title: Text("H O M E"),
            leading: Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text("S E T T I N G S"),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}
