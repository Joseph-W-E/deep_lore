import 'package:f_web/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownViewer extends StatelessWidget {
  const MarkdownViewer({
    super.key,
    required this.file,
    required this.onClose,
  });

  final GithubFile file;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: GithubApi().getMarkdown(file),
      builder: (context, snapshot) {
        final data = snapshot.data;

        final Widget child;
        if (snapshot.hasError) {
          child = const Center(
            child: Text('Failed to load'),
          );
        } else if (data == null) {
          child = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          child = SelectionArea(
            child: MarkdownBody(
              data: data,
              selectable: true,
            ),
          );
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  child,
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
