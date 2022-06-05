import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/strings.dart';
import '../cubits/event_cubit.dart';
import '../theme/zeplin_colors.dart';
import '../theme/zeplin_text_style.dart';
import '../widgets/event_card.dart';

class EventScreen extends StatefulWidget {
  int id;
  EventScreen(this.id);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String qrCode = 'Unknown';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventCubit>(context).getEvent(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            title: Text(
              Strings.appbar_headline_Event.toUpperCase(),
              style: ZeplinTextStyles.HeadlinePrimaryWhite24SP,
            ),
            backgroundColor: ZeplinColors.primary_blue,
          ),
        ),
        body: Container(
            child: Container(
          padding: const EdgeInsets.only(top: 50),
          color: ZeplinColors.scaffold_background,
          child: BlocBuilder<EventCubit, EventState>(
            builder: (context, state) {
              //print(snapshot.hasData);
              if (!(state is EventScreenLoaded))
                //List<Events> events = snapshot.data;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );

              final event = (state as EventScreenLoaded).event;

              return EventCard(event!);
            },
          ),
        )));
  }
}
