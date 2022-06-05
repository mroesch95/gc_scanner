import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/cubits/events_cubit.dart';
import 'package:scanner/cubits/ticket_cubit.dart';
import 'package:scanner/pages/scan_page.dart';
import 'package:scanner/screens/events_screen.dart';
import 'package:scanner/screens/login_screen.dart';

import 'package:scanner/screens/scanner_screen.dart';
import 'package:scanner/services/events_service.dart';

class TicketPage extends StatelessWidget {
  String scanQRcode;
  TicketPage({Key? key, required this.scanQRcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
            create: (context) => TicketCubit()..checkTicket(scanQRcode),
            child: Center(
              child: ScannerScreen(scanQRcode), //Splash(),
            )));
  }
}
