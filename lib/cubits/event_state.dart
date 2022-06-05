part of 'event_cubit.dart';

//@immutable

abstract class EventState {}

class EventInitial extends EventState {}

class EventScreenLoaded extends EventState {
  final Event? event;

  EventScreenLoaded({this.event});
}

class EventScreenCheckImageStatusStarting extends EventState {
  EventScreenCheckImageStatusStarting();
}

class EventScreenCheckImageStatusPass extends EventState {
  EventScreenCheckImageStatusPass();
}

class EventScreenCheckImageStatusFail extends EventState {
  EventScreenCheckImageStatusFail();
}
