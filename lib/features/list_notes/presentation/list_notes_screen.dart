import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is AuthSignedIn,
      builder: (context, state) {
        if (state is AuthSignedIn) {
          return CupertinoPageScaffold(
            resizeToAvoidBottomInset: false,
            navigationBar: CupertinoNavigationBar(
              middle: const Text('List Notes'),
              trailing: CupertinoButton(
                child: const Icon(
                    CupertinoIcons.arrowshape_turn_up_right_circle_fill),
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
              ),
            ),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CupertinoListTile(
                  title: Text('Note $index'),
                  subtitle: Text('Note $index'),
                );
              },
            ),
          );
        } else if (state is AuthSignedOut) {
          return const CupertinoPageScaffold(
            child: Center(
              child: Text('Error'),
            ),
          );
        } else {
          return const CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
