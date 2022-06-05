import 'dart:convert';

import 'package:http/http.dart';
import 'package:scanner/db/db.dart';
import 'package:scanner/services/internet_service.dart';

import '../constants/strings.dart';
import '../models/event.dart';

import '../models/eventBeans.dart';
import '../models/events.dart';
import 'base_service.dart';

class EventService extends ApiBaseService {
  OfflineDB offlineDB = OfflineDB();

  Future<Event> getEvent(id) async {
    List<Events> eventsList = [];
    Event event = Event(
        id: -1,
        titel: '',
        terminVon: DateTime(2022),
        terminBis: DateTime(2022),
        imageUrl: '',
        anzahlGesamtTickets: 0,
        anzahlTicketkaufOnline: 0,
        anzahlTicketkaufKasse: 0,
        gaesteAktuell: 0);

    await InternetService().isInternet().then((internet) async {
      if (internet) {
        print('online');
        dynamic eventJson = await getData(Strings.events_url);
        eventsList = eventsFromJson(eventJson);
        for (int i = 0; i < eventsList.length; i++) {
          Events events = eventsList[i];

          if (events.id == id) {
            event = Event(
                id: events.id,
                titel: events.titel,
                terminVon: events.terminVon,
                terminBis: events.terminBis,
                imageUrl: events.imageUrl,
                anzahlGesamtTickets: events.anzahlGesamtTickets,
                anzahlTicketkaufOnline: events.anzahlTicketkaufOnline,
                anzahlTicketkaufKasse: events.anzahlTicketkaufKasse,
                gaesteAktuell: events.gaesteAktuell);
          }
        }
      } else {
        print('offline');
        List<EventBeans> eventList = await offlineDB.getEventById(id);
        for (int i = 0; i < eventList.length; i++) {
          EventBeans eventBeans = eventList[i];
          print(eventBeans.id);
          print(id);
          if (eventBeans.id == id.toString()) {
            print('id is matching');

            event = Event(
                id: eventBeans.id,
                titel: eventBeans.titel,
                terminVon: DateTime.parse(eventBeans.terminVon),
                terminBis: DateTime.parse(eventBeans.terminBis),
                imageUrl: eventBeans.imageUrl,
                anzahlGesamtTickets: eventBeans.anzahlGesamtTickets,
                anzahlTicketkaufOnline: eventBeans.anzahlTicketkaufOnline,
                anzahlTicketkaufKasse: eventBeans.anzahlTicketkaufKasse,
                gaesteAktuell: eventBeans.gaesteAktuell);
          } else {
            print('not found id');
          }
        }
      }
    });

    return event;
  }

  Future<void> updateEventOnline(
      int eventID, int gaesteAktuell, int anzahlTicketOnline) async {
    final url = Uri.parse(Strings.update_online);
    var gaesteNew = gaesteAktuell + 1;
    var anzahlTicketOnlineNew = anzahlTicketOnline + 1;
    final headers = {"Content-type": "application/json"};
    final json = {
      "eventId": eventID,
      "gaesteAktuell": gaesteNew,
      "anzahlTicketOnline": anzahlTicketOnlineNew
    };
    final response = await patch(url, headers: headers, body: jsonEncode(json));
    print(eventID);
    print('Status code: ${response.statusCode}');
    print(json);
    //print('Body: ${response.body}');
  }

  Future<void> updateEventKasse(
      int eventID, int gaesteAktuell, int anzahlTicketKasse) async {
    final url = Uri.parse(Strings.update_kasse);
    var gaesteNew = gaesteAktuell + 1;
    var anzahlTicketKasseNew = anzahlTicketKasse + 1;
    final headers = {"Content-type": "application/json"};
    final json = {
      "eventId": eventID,
      "gaesteAktuell": gaesteNew,
      "anzahlTicketKaufKasse": anzahlTicketKasseNew
    };
    final response = await patch(url, headers: headers, body: jsonEncode(json));
    print(eventID);
    print('Status code: ${response.statusCode}');
    print(json);
    //print('Body: ${response.body}');
  }
}
