import 'package:f_web/network.dart';
import 'package:f_web/widgets/file_tile.dart';
import 'package:flutter/material.dart';

class FolderTile extends StatelessWidget {
  const FolderTile({super.key, required this.folder});

  final GithubFolder folder;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(folder.name),
      children: [
        for (final f in folder.folders)
          FolderTile(
            folder: f,
          ),
        for (final f in folder.files)
          FileTile(
            file: f,
          ),
      ],
    );
  }
}
