import 'package:f_web/network.dart';
import 'package:f_web/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileTile extends StatelessWidget {
  const FileTile({super.key, required this.file});

  final GithubFile file;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(file.name),
      onTap: () {
        context.read<HomeBloc>().add(OpenFile(file));
      },
    );
  }
}
