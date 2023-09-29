import 'package:flutter/cupertino.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ListNotesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('List Notes Screen'),
      ),
    );
  }
}
