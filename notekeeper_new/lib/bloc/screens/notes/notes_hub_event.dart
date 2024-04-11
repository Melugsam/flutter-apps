part of 'notes_hub_bloc.dart';

sealed class NotesHubEvent {}

class FetchNotesEvent extends NotesHubEvent{
  final NotesDB notesDB;
  FetchNotesEvent({required this.notesDB});

}
