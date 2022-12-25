import 'package:f_web/network.dart';
import 'package:f_web/widgets/folder_tile.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key, required this.root});

  final GithubFolder root;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: FolderTile(
              folder: root,
            ),
          ),
        ],
      ),
    );
  }
}
