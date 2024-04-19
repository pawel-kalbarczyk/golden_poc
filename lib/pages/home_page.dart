import 'package:flutter/material.dart';
import 'package:golden_poc/core/gen/l10n.dart';
import 'package:golden_poc/widgets/tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Golden POC',
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.lightBlue,
          child: ListView(
            children: const [
              DrawerHeader(child: Text('Menu')),
              ListTile(title: Text('First menu item')),
              ListTile(
                title: Text('Second menu item'),
              )
            ],
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sample text'),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TileWidget(showError: false),
                  SizedBox(width: 20),
                  TileWidget(
                    showError: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextButton(
              key: const ValueKey('button'),
              onPressed: () => _showDialog(context),
              child: const Text('Display dialog'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(8),
                  color: Color.fromRGBO(30, 30, 120 + (index * 5), 1),
                  child: Text(S.of(context).listTileTitle(index), style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Dialog title'),
                  ],
                ),
              ));
        });
  }
}
