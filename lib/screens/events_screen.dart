import 'package:flutter/material.dart';
import 'package:scanner/constants/strings.dart';
import 'package:scanner/theme/zeplin_colors.dart';
import 'package:scanner/theme/zeplin_text_style.dart';
import '../cubits/events_cubit.dart';
import '../widgets/event_list_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  //late Future<List<Events>> _events;
  String qrCode = 'Unknown';

  @override
  void initState() {
    super.initState();
    //_events = EventsService().getEvents();
    BlocProvider.of<EventsCubit>(context).getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            title: Text(
              Strings.appbar_headline_Events.toUpperCase(),
              style: ZeplinTextStyles.HeadlinePrimaryWhite24SP,
            ),
            backgroundColor: ZeplinColors.primary_blue,
            automaticallyImplyLeading: false,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50),
          color: ZeplinColors.scaffold_background,
          child: BlocBuilder<EventsCubit, EventsState>(
            builder: (context, state) {
              //print(snapshot.hasData);
              if (!(state is EventsLoaded))
                //List<Events> events = snapshot.data;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );

              final events = (state as EventsLoaded).events;

              return EventListCard(events!);
            },
          ),
        ));
  }
}
