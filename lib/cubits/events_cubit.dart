import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:scanner/services/event_service.dart';
import 'package:scanner/services/events_service.dart';

import '../models/events.dart';
part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsService service;

  EventsCubit({required this.service}) : super(EventsScreenInitial());

  void getEvents() {
    Timer(Duration(seconds: 3), () {
      service.getEvents().then((events) {
        emit(EventsLoaded(events: events));
      });
    });
  }
}
