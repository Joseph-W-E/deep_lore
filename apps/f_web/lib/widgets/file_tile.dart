import 'package:f_web/network.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FileTile extends StatelessWidget {
  const FileTile({super.key, required this.file});

  final GithubFile file;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(file.name),
      onTap: () {
        context.go(file.route);
      },
    );
  }
}
