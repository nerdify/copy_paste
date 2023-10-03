import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.watch<AuthCubit>().state is AuthSignedIn;

    return Padding(
      padding: const EdgeInsets.only(top: 70, bottom: 100, right: 40, left: 40),
      child: Column(
        children: [
          Image.network(
            'https://logo.clearbit.com/firebase.com?size=200',
            height: 200,
            width: 200,
          ),

          ///
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'Sign in or create an account',
                style: TextStyle(
                  fontSize: 24,
                  color: CupertinoColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          ///
          const SizedBox(height: 20),
          if (isSigningIn) const CupertinoActivityIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _LoginButton(
                  text: 'Sign in with Google',
                  onTap: () => context.read<AuthCubit>().signInWithGoogle(),
                  color: CupertinoColors.systemBlue,
                  textColor: CupertinoColors.systemGrey,
                  image: 'https://logo.clearbit.com/google.com?size=200',
                ),
                const SizedBox(height: 20),
                _LoginButton(
                  text: 'Sign in with Anonymous',
                  onTap: () => context.read<AuthCubit>().signInAnonymously(),
                  color: CupertinoColors.systemPurple,
                  textColor: CupertinoColors.systemGrey,
                  image: 'https://logo.clearbit.com/firebase.com?size=200',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String text;
  final String image;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _LoginButton({
    Key? key,
    required this.text,
    required this.image,
    required this.color,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                image,
                height: 24,
                width: 24,
              ),
              const SizedBox(height: 20),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
