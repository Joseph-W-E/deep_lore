import 'dart:async';

import 'package:f_web/network.dart';
import 'package:f_web/widgets/background.dart';
import 'package:f_web/widgets/folder_tile.dart';
import 'package:f_web/widgets/markdown_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.root});

  final GithubFolder? root;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Scaffold(
        body: Row(
          children: [
            _VerticalNavigator(root: root),
            const VerticalDivider(),
            const Expanded(child: _TabBody()),
          ],
        ),
      ),
    );
  }
}

class _VerticalNavigator extends StatelessWidget {
  const _VerticalNavigator({required this.root});

  final GithubFolder? root;

  @override
  Widget build(BuildContext context) {
    final root = this.root;
    return Container(
      width: 200,
      alignment: Alignment.topCenter,
      child: root == null
          ? Container()
          : SingleChildScrollView(
              child: FolderTile(folder: root),
            ),
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody();

  @override
  Widget build(BuildContext context) {
    final files = context.watch<HomeBloc>().state.openedFiles;

    return Stack(
      children: [
        const Background(),
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final file in files)
              MarkdownViewer(
                key: ValueKey(file),
                file: file,
                onClose: () {
                  context.read<HomeBloc>().add(CloseFile(file));
                },
              ),
          ],
        ),
      ],
    );
  }
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<OpenFile>(_onOpenFile);
    on<CloseFile>(_onCloseFile);
  }

  FutureOr<void> _onOpenFile(OpenFile event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        openedFiles: [
          event.file,
          ...List.of(state.openedFiles)..remove(event.file),
        ],
      ),
    );
  }

  FutureOr<void> _onCloseFile(CloseFile event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        openedFiles: List.of(state.openedFiles)..remove(event.file),
      ),
    );
  }
}

abstract class HomeEvent {}

class OpenFile extends HomeEvent {
  OpenFile(this.file);

  final GithubFile file;
}

class CloseFile extends HomeEvent {
  CloseFile(this.file);

  final GithubFile file;
}

class HomeState {
  const HomeState({
    this.openedFiles = const [],
  });

  final List<GithubFile> openedFiles;

  HomeState copyWith({
    List<GithubFile>? openedFiles,
  }) {
    return HomeState(
      openedFiles: openedFiles ?? this.openedFiles,
    );
  }
}
