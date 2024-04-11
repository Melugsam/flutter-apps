part of 'notes_hub_bloc.dart';

sealed class NotesHubState {}

final class NotesHubInitial extends NotesHubState {}
class NotesLoadingState extends NotesHubState{}
class NotesErrorState extends NotesHubState{}
class NotesFetchedState extends NotesHubState{
  final List<Note> pinnedNotes;
  final List<Note> unpinnedNotes;

  NotesFetchedState({required this.pinnedNotes, required this.unpinnedNotes});
}
