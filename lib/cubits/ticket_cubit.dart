import 'package:bloc/bloc.dart';
import 'package:scanner/db/db.dart';
import 'package:scanner/models/eventBeans.dart';
import 'package:scanner/models/ticketBeans.dart';
import 'package:scanner/services/events_service.dart';
import 'package:scanner/services/internet_service.dart';
import '../models/events.dart';
import '../models/tickets.dart';
import '../services/event_service.dart';
import '../services/tickets_service.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  TicketCubit() : super(TicketInitial());

  int ticketStatus = 0;
  OfflineDB db = OfflineDB();

  Future<void> checkTicket(String qrInput) async {
    late int gaesteAktuell;
    late int anzahlTicketOnline;
    late int anzahlTicketKasse;
    await InternetService().isInternet().then((internet) async {
      if (internet) {
        List<Tickets> ticketsList = await TicketsService().getTickets();
        List<Events> eventsList = await EventsService().getEvents();

        db.deleteTickets();

        for (int i = 0; i < ticketsList.length; i++) {
          db.insertTicketRecord(TicketBeans(
              ticketId: ticketsList[i].ticketId,
              qrCode: ticketsList[i].qrCode,
              ticketScanned: ticketsList[i].ticketScanned,
              eventId: ticketsList[i].eventId));

          if (qrInput == ticketsList[i].qrCode &&
              ticketsList[i].ticketScanned == 0 &&
              qrInput.contains('ONLINE')) {
            for (int j = 0; j < eventsList.length; j++) {
              if (eventsList[j].id == ticketsList[i].eventId) {
                gaesteAktuell = eventsList[j].gaesteAktuell;
                anzahlTicketOnline = eventsList[j].anzahlTicketkaufOnline;
              }
            }
            TicketsService().updateTicket(ticketsList[i].ticketId);

            EventService().updateEventOnline(
                ticketsList[i].eventId, gaesteAktuell, anzahlTicketOnline);
            ticketStatus = 1;
          } else if (qrInput == ticketsList[i].qrCode &&
              ticketsList[i].ticketScanned == 0 &&
              qrInput.contains('KASSE')) {
            for (int j = 0; j < eventsList.length; j++) {
              if (eventsList[j].id == ticketsList[i].eventId) {
                gaesteAktuell = eventsList[j].gaesteAktuell;
                anzahlTicketKasse = eventsList[j].anzahlTicketkaufKasse;
              }
            }
            TicketsService().updateTicket(ticketsList[i].ticketId);

            EventService().updateEventKasse(
                ticketsList[i].eventId, gaesteAktuell, anzahlTicketKasse);
            ticketStatus = 1;
          } else if (qrInput == ticketsList[i].qrCode &&
              ticketsList[i].ticketScanned == 1) {
            ticketStatus = 2;

            emit(TicketAlreadyScanned());
          }
        }
      } else {
        print('offline');
        List<TicketBeans> ticketsListOffline = await db.getTickets();
        List<EventBeans> eventsListOffline = await db.getEvents();
        print(ticketsListOffline);
        for (int i = 0; i < ticketsListOffline.length; i++) {
          if (qrInput == ticketsListOffline[i].qrCode &&
              ticketsListOffline[i].ticketScanned == 0 &&
              qrInput.contains('ONLINE')) {
            for (int j = 0; j < eventsListOffline.length; j++) {
              if (eventsListOffline[j].id == ticketsListOffline[i].eventId) {
                gaesteAktuell = eventsListOffline[j].gaesteAktuell + 1;
                anzahlTicketOnline =
                    eventsListOffline[j].anzahlTicketkaufOnline + 1;
              }
            }

            db.updateTicket(TicketBeans(
                ticketId: ticketsListOffline[i].ticketId,
                qrCode: ticketsListOffline[i].qrCode,
                ticketScanned: 1,
                eventId: ticketsListOffline[i].eventId));
            db.updateEventDBOnline(EventBeans(
                id: eventsListOffline[i].id,
                titel: eventsListOffline[i].titel,
                terminVon: eventsListOffline[i].terminVon,
                terminBis: eventsListOffline[i].terminBis,
                imageUrl: eventsListOffline[i].imageUrl,
                anzahlGesamtTickets: eventsListOffline[i].anzahlGesamtTickets,
                anzahlTicketkaufOnline: anzahlTicketOnline,
                anzahlTicketkaufKasse:
                    eventsListOffline[i].anzahlTicketkaufKasse,
                gaesteAktuell: gaesteAktuell));

            ticketStatus = 1;
          } else if (qrInput == ticketsListOffline[i].qrCode &&
              ticketsListOffline[i].ticketScanned == 0 &&
              qrInput.contains('KASSE')) {
            for (int j = 0; j < eventsListOffline.length; j++) {
              if (eventsListOffline[j].id == ticketsListOffline[i].eventId) {
                gaesteAktuell = eventsListOffline[j].gaesteAktuell + 1;
                anzahlTicketKasse =
                    eventsListOffline[j].anzahlTicketkaufKasse + 1;
              }
            }

            db.updateTicket(TicketBeans(
                ticketId: ticketsListOffline[i].ticketId,
                qrCode: ticketsListOffline[i].qrCode,
                ticketScanned: 1,
                eventId: ticketsListOffline[i].eventId));

            db.updateEventDBKasse(EventBeans(
                id: eventsListOffline[i].id,
                titel: eventsListOffline[i].titel,
                terminVon: eventsListOffline[i].terminVon,
                terminBis: eventsListOffline[i].terminBis,
                imageUrl: eventsListOffline[i].imageUrl,
                anzahlGesamtTickets: eventsListOffline[i].anzahlGesamtTickets,
                anzahlTicketkaufOnline:
                    eventsListOffline[i].anzahlTicketkaufOnline,
                anzahlTicketkaufKasse: anzahlTicketKasse,
                gaesteAktuell: gaesteAktuell));

            ticketStatus = 1;
          } else if (qrInput == ticketsListOffline[i].qrCode &&
              ticketsListOffline[i].ticketScanned == 1) {
            ticketStatus = 2;
          }
        }
      }
    });

    if (ticketStatus == 1) {
      emit(TicketSuccess());
    } else if (ticketStatus == 2) {
      emit(TicketAlreadyScanned());
    } else {
      emit(TicketNotFound());
    }
  }
}
