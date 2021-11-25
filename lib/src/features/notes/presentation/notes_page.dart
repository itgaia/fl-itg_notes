import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itg_notes/src/features/notes/domain/get_notes_usecase.dart';

import '../../../../injection_container.dart';
import 'notes_bloc.dart';
import 'notes_list.dart';

class NotesPage extends StatelessWidget {
  static const routeName = '/notes';

  final String title;

  const NotesPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider(
        create: (context) => sl<NotesBloc>()..add(GetNotesEvent()),
        // create: (_) => NotesBloc(notes: GetNotesUsecase())..add(GetNotesEvent()),
        child: NotesList(),
      ),
    );
  }
}

// class NotesPage extends StatelessWidget {
//   // final NotesCubit notesCubit;
//   final String title;
//
//   // const NotesPage({Key? key, required this.title, required this.notesCubit}) : super(key: key);
//   const NotesPage({Key? key, required this.title}) : super(key: key);
//
//   static const routeName = '/notes';
//
//   // Sending the Note to the next page:
//   // _goToNotePage(BuildContext context, {NotesEntity? note}) => Navigator.push(
//   //   context,
//   //   MaterialPageRoute(
//   //     builder: (context) => NotePage(
//   //       notesCubit: notesCubit,
//   //       note: note,
//   //     ),
//   //   ),
//   // );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: SingleChildScrollView(
//         child: buildBody(context),
//       ),
//     );
//   }
//
//   BlocProvider<NotesBloc> buildBody(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<NotesBloc>(),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               // Top half
//               BlocBuilder<NotesBloc, NotesState>(
//                 builder: (context, state) {
//                   if (state is Empty) {
//                     return const MessageDisplay(message: 'Start searching!');
//                   } else if (state is Loading) {
//                     return const LoadingWidget();
//                   } else if (state is Loaded) {
//                     return NotesDisplay(notes: state.notes);
//                   } else if (state is Error) {
//                     return MessageDisplay(message: state.message);
//                   }
//                   return Container();
//                 },
//               ),
//               const SizedBox(height: 20),
//               // Bottom half
//               const NotesControls(),
//
//               const SizedBox(height: 10),
//
//               SizedBox(
//                   height: MediaQuery.of(context).size.height / 3 - 31,
//                   child: Image.asset('assets/images/background.png')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
