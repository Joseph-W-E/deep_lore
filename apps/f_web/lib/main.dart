import 'package:f_web/network.dart';
import 'package:f_web/pages/home_page.dart';
import 'package:f_web/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  runApp(const _App());
}

class _App extends StatefulWidget {
  const _App({Key? key}) : super(key: key);

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  GithubFolder? _root;
  var _didError = false;

  @override
  void initState() {
    super.initState();
    _get();
  }

  void _get() async {
    final api = GithubApi();
    try {
      final root = await api.getContents();
      if (!mounted) return;
      setState(() => _root = root);
    } catch (_) {
      setState(() => _didError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppTheme.title,
      theme: AppTheme.make(),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => HomePage(
              root: _root,
            ),
          ),
        ],
      ),
    );
  }
}
