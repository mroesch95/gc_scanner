import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/cubits/events_cubit.dart';
import 'package:scanner/screens/events_screen.dart';
import 'package:scanner/screens/login_screen.dart';

import 'package:scanner/services/events_service.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) =>
              EventsCubit(service: EventsService())..getEvents(),
          child: Center(
            child: EventsScreen(), //Splash(),
          )),
    );
  }
}
