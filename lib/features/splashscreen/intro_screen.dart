import 'package:copy_paste/features/splashscreen/widgets/intro_page.dart';
import 'package:flutter/cupertino.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static const String routeName = '/intro';

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const IntroScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: IntroPage(),
    );
  }
}
