import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:scanner/models/event.dart';
import 'package:scanner/services/event_service.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventService service;

  EventCubit({required this.service}) : super(EventInitial());

  void getEvent(id) {
    Timer(Duration(seconds: 3), () {
      service.getEvent(id).then((event) {
        emit(EventScreenLoaded(event: event));
      });
    });
  }

  Future<void> checkImageStatus(url) async {
    emit(EventScreenCheckImageStatusStarting());
    final response = await InternetAddress.lookup(url);
    if (response.isNotEmpty) {
      emit(EventScreenCheckImageStatusPass());
    } else {
      emit(EventScreenCheckImageStatusFail());
    }
  }
}
