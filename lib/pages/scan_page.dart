import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/screens/scanner_screen.dart';

import '../cubits/ticket_cubit.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TicketCubit()
          ..checkTicket(
            'KASSE333',
          ),
        child: ScannerScreen(
          'KASSE333',
        ));
  }
}
