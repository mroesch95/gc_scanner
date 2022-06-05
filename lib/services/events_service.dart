import 'package:scanner/db/db.dart';
import 'package:scanner/models/eventBeans.dart';
import 'package:scanner/services/internet_service.dart';
import '../constants/strings.dart';
import '../models/events.dart';
import 'base_service.dart';

class EventsService extends ApiBaseService {
  OfflineDB offlineDB = OfflineDB();

  Future<List<Events>> getEvents() async {
    List<Events> events = [];
    await InternetService().isInternet().then((internet) async {
      if (internet) {
        dynamic eventsListJson = await getData(Strings.events_url);
        events = eventsFromJson(eventsListJson);
        offlineDB.deleteEvents();
        for (int index = 0; index < events.length; index++) {
          Events event = events[index];
          offlineDB.insertEventRecord(EventBeans(
              id: event.id,
              titel: event.titel,
              terminVon: event.terminVon.toString(),
              terminBis: event.terminBis.toString(),
              imageUrl: event.imageUrl,
              anzahlGesamtTickets: event.anzahlGesamtTickets,
              anzahlTicketkaufOnline: event.anzahlTicketkaufOnline,
              anzahlTicketkaufKasse: event.anzahlTicketkaufKasse,
              gaesteAktuell: event.gaesteAktuell));
        }
        print('online');
      } else {
        List<EventBeans> eventList = await offlineDB.getEvents();
        print(eventList);
        for (int index = 0; index < eventList.length; index++) {
          EventBeans eventBeans = eventList[index];
          events.add(Events(
              id: eventBeans.id,
              titel: eventBeans.titel,
              terminVon: DateTime.parse(eventBeans.terminVon),
              terminBis: DateTime.parse(eventBeans.terminBis),
              imageUrl: eventBeans.imageUrl,
              anzahlGesamtTickets: eventBeans.anzahlGesamtTickets,
              anzahlTicketkaufOnline: eventBeans.anzahlTicketkaufOnline,
              anzahlTicketkaufKasse: eventBeans.anzahlTicketkaufKasse,
              gaesteAktuell: eventBeans.gaesteAktuell));
        }
        print('offline');

        //return events;
      }
    });
    return events;
  }
}
