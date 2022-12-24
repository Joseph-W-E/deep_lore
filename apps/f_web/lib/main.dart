import 'package:f_web/network.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  final api = GithubApi();
  // todo

  runApp(_App(api));
}

class _App extends StatelessWidget {
  final GithubApi _api;

  const _App(this._api);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Deep Lore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => MyHomePage(
              api: _api,
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.api});

  final GithubApi api;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GithubFolder? _folder;

  void _get() async {
    final root = await widget.api.getContents();
    if (!mounted) return;

    setState(() {
      _folder = root;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hey lol'),
      ),
      body: Center(
        child: ListView(
          children: [
            Text(
              'Github API Result:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _get,
        tooltip: 'Hit Github Hard BB',
        child: const Icon(Icons.send),
      ),
    );
  }
}
