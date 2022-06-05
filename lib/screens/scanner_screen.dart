import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/cubits/ticket_cubit.dart';
import 'package:scanner/models/tickets.dart';
import 'package:scanner/services/event_service.dart';

import 'package:scanner/services/tickets_service.dart';

import '../constants/strings.dart';
import '../models/event.dart';
import '../services/base_service.dart';
import '../services/event_service.dart';

class ScannerScreen extends StatelessWidget {
  String _scanQRcode;

  ScannerScreen(
    this._scanQRcode,
  );

  Future<List<Tickets>> tickets = TicketsService().getTickets();
/*
  String checkTicket(String qrInput, List<Tickets> tickets) {
    for (int i = 0; i < tickets.length; i++) {
      if (qrInput ==
          tickets[i]
              .qrCode) /* && tickets[i].qrCode.contains('KASSE') nicht notwendig da Kasse und online im qr code vorkommen somit ist er unique*/ {
        TicketsService().updateTicket(tickets[i].ticketId);

        EventService().updateEvent(tickets[i].eventId, gaesteAktuell);
        return Strings.allert_dialog_success;
      }
    }
    return Strings.allert_dialog_no_success;
  }
*/
/*
  String checkQRCode(String qrInput, String qrDatabase) {
    if (qrInput == qrDatabase) {
      return Strings.allert_dialog_success;
    } else {
      return Strings.allert_dialog_no_success;
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Text(
            Strings.appbar_headline_Event.toUpperCase(),
            //style: ZeplinTextStyles.HeadlinePrimaryWhite24SP,
          ),
          //backgroundColor: ZeplinColors.primary_blue,
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
          if (state is TicketSuccess) {
            return buildCenterText(Strings.allert_dialog_success, Colors.green);
          } else if (state is TicketNotFound) {
            return buildCenterText(
                Strings.allert_dialog_no_success, Colors.amber);
          } else if (state is TicketAlreadyScanned) {
            return buildCenterText(
                Strings.allert_dialog_already_scanned, Colors.green);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.red));
          }
        }),
        /*child: FutureBuilder(
          future: tickets,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.hasData);
            if (snapshot.hasData) {
              List<Tickets> ticketData = snapshot.data;

              //_ticketQRCode = ticketData.qrCode;

              return Center(
                child: (AlertDialog(
                  title: Text(checkTicket(_scanQRcode, ticketData)),
                )),
              );
            } else {
              return CircularProgressIndicator(
                color: Colors.yellow,
              );
            }
          },
        ),*/
      ),
    );
  }

  Center buildCenterText(title, color) {
    return Center(
      child: (AlertDialog(
        title: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              // style: TextStyle(fontSize: 22, color: color),
              //textAlign: TextAlign.center,
            )),
      )),
    );
  }
}
