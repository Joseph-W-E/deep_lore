import 'package:f_web/network.dart';
import 'package:f_web/theme.dart';
import 'package:f_web/widgets/background.dart';
import 'package:f_web/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  runApp(const _LoadingApp());
  final root = await GithubApi().getContents();
  await Future.delayed(const Duration(milliseconds: 1000));
  runApp(_LoadedApp(root: root));
}

class _LoadingApp extends StatelessWidget {
  const _LoadingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTheme.title,
      theme: AppTheme.make(),
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _LoadedApp extends StatelessWidget {
  const _LoadedApp({required this.root});

  final GithubFolder root;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppTheme.title,
      theme: AppTheme.make(),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => _HomePage(
              root: root,
            ),
            routes: [],
          ),
        ],
      ),
    );
  }

  GoRoute _toGoRoute(GithubFolder folder) {
    return GoRoute(
      path: '${folder.name}/',
      builder: (_, __) => const Placeholder(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({required this.root});

  final GithubFolder root;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Row(
            children: [
              NavDrawer(
                root: root,
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
