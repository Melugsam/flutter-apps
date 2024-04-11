import 'package:bloc/bloc.dart';
import 'package:notekeeper_new/domain/models/note.dart';
import 'package:notekeeper_new/domain/models/notes_db.dart';
part 'notes_hub_event.dart';
part 'notes_hub_state.dart';

class NotesHubBloc extends Bloc<NotesHubEvent, NotesHubState> {
  NotesHubBloc() : super(NotesHubInitial()) {
    on<FetchNotesEvent>((event, emit) async {
      emit(NotesLoadingState());
      try{
        final notes = await event.notesDB.fetchAll();
        final pinnedNotes = notes.where((note) => note.isPinned==1).toList();
        final unpinnedNotes = notes.where((note) => note.isPinned==0).toList();
        emit(NotesFetchedState(pinnedNotes: pinnedNotes, unpinnedNotes: unpinnedNotes));
      }
      catch(ex){
        emit(NotesErrorState());
      }
    });
  }
}
