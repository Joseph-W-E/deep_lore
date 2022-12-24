import 'dart:convert';

import 'package:http/http.dart' as http;

class GithubApi {
  static const _documentationEndpoint =
      'https://api.github.com/repos/joseph-w-e/deep_lore/contents/documentation';

  Future<GithubFolder> getContents() async {
    // todo wrap this in a try-catch and return a failed
    final body = (await http.get(Uri.parse(_documentationEndpoint))).body;

    print('JOEY - body:\n$body\n------');

    return GithubFolder.fromJson(
      jsonDecode(
        body,
      ),
    );
  }
}

class GithubFolder {
  final String name;
  final List<GithubFile> files;

  GithubFolder({required this.name, required this.files});

  factory GithubFolder.fromJson(Map<String, dynamic> json) {
    return GithubFolder(
      name: json['name'], // todo
      files: [], // todo
    );
  }
}

class GithubFile {
  final String name;
  final String downloadUrl;

  GithubFile({required this.name, required this.downloadUrl});

  factory GithubFile.fromJson(Map<String, dynamic> json) {
    return GithubFile(
      name: json['name'],
      downloadUrl: json['download_url'],
    );
  }
}
