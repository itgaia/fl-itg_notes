import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itg_notes/src/app_helper.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/bottom_loader.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/loading_widget.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/notes_display.dart';
import 'package:itg_notes/src/features/notes/presentation/widgets/notes_list_item.dart';

import 'notes_bloc.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        print('>>> [NotesList/BlocBuilder] state: $state');
        if (state is Empty) {
          return const Center(child: Text('no notes'));
        } else if (state is Loading) {
          return const LoadingWidget(key: keyProgressIndicatorMain);
        } else if (state is Loaded) {
          // return NotesDisplay(notes: state.notes);
          print('>>> [NotesList/BlocBuilder] state is Loaded...');
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              print('>>> [NotesList/ListView.builder] index: $index, state.notes.length: ${state.notes.length}');
              return index >= state.notes.length
                  ? BottomLoader()
                  : NotesListItem(note: state.notes[index]);
            },
            itemCount: state.hasReachedMax
                ? state.notes.length
                : state.notes.length + 1,
            controller: _scrollController,
          );
        } else if (state is Error) {
          // return MessageDisplay(message: state.message);
          return const Center(child: Text('failed to fetch notes'));
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NotesBloc>().add(GetNotesEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
