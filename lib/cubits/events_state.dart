part of 'events_cubit.dart';

//@immutable
abstract class EventsState {}

class EventsScreenInitial extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Events>? events;

  EventsLoaded({this.events});
}
