import 'dart:convert';

import 'package:f_web/theme.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  Future<GithubFolder> getContents() async {
    const baseUrl = 'https://api.github.com/repos/joseph-w-e/deep_lore';
    const masterUrl = '$baseUrl/branches/master';
    const treeUrl = '$baseUrl/git/trees';

    final sha = (await _get(masterUrl))['commit']['sha'].toString();
    final tree = (await _get('$treeUrl/$sha?recursive=1'))['tree'];

    final root = GithubFolder(name: AppTheme.title);

    for (final obj in tree) {
      final path = obj['path'].toString().split('/');

      if (path.isNotEmpty && path.first == 'apps') continue;
      if (path.length == 1 && path.first == 'documentation') continue;

      root.add(path);
    }

    return root;
  }

  Future<String> getMarkdown(GithubFile file) async {
    const baseUrl =
        'https://api.github.com/repos/joseph-w-e/deep_lore/contents';
    final contents = (await _get('$baseUrl/${file.route}'));
    final downloadUrl = contents['download_url'];
    return (await _getRaw(downloadUrl));
  }

  Future<dynamic> _get(String url) async =>
      jsonDecode((await http.get(Uri.parse(url))).body);

  Future<String> _getRaw(String url) async =>
      (await http.get(Uri.parse(url))).body;
}

class GithubFolder {
  final String name;
  final GithubFolder? parent;
  final List<GithubFolder> folders;
  final List<GithubFile> files;

  GithubFolder({
    required this.name,
    this.parent,
    List<GithubFolder>? folders,
    List<GithubFile>? files,
  })  : folders = folders ?? [],
        files = files ?? [];

  void add(List<String> path) {
    if (path.isEmpty) {
      return;
    } else if (path.length == 1) {
      final fileName = path.first;

      // Casually ignore non-files.
      if (!fileName.contains('.')) return;

      files.add(
        GithubFile(
          name: fileName,
          parent: this,
        ),
      );
    } else {
      final f = path.first;

      // Dig through the existing folders and add there.
      // If an existing folder matches, then we can early out after adding.
      for (final folder in folders) {
        if (folder.name == f) {
          folder.add(path.sublist(1));
          return;
        }
      }

      // Otherwise, no folder was a match so we need to make a new one.
      folders.add(
        GithubFolder(
          name: f,
          parent: this,
        )..add(path.sublist(1)),
      );
    }
  }
}

class GithubFile {
  final String name;
  final GithubFolder parent;

  GithubFile({required this.name, required this.parent});

  String get route {
    final path = [name];

    GithubFolder? parent = this.parent;
    while (parent != null) {
      path.insert(0, parent.name);
      parent = parent.parent;
    }

    path.removeAt(0); // remove Deep Lore hardcoded folder

    return path.join('/');
  }
}
