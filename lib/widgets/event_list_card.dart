import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scanner/cubits/event_cubit.dart';
import 'package:scanner/services/event_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/screens/event_screen.dart';
import 'package:scanner/theme/zeplin_colors.dart';
import '../constants/strings.dart';
import '../models/events.dart';
import '../theme/zeplin_text_style.dart';
import 'package:http/http.dart' as http;

class EventListCard extends StatelessWidget {
  @override
  List<Events> events;

  EventListCard(this.events);

  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: buildContainer(context, index),
          );
        });
  }

  Container buildContainer(BuildContext context, int index) {
    return Container(
      height: 110,
      width: 328,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                    create: (_) => EventCubit(service: EventService()),
                    child: EventScreen(events[index].id)))),
        child: Card(
          color: ZeplinColors.white,
          child: Row(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(events[index].imageUrl),
                        fit: BoxFit.cover,
                      ))),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 11, left: 11),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: SizedBox(
                              height: 22,
                              width: 20,
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                              )),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(events[index].terminVon),
                          style: ZeplinTextStyles.CalendarDayBlack,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 11, left: 11),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 22,
                            width: 20,
                            child: Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm').format(events[index].terminVon),
                          style: ZeplinTextStyles.CalendarDayBlack,
                        ),
                        const Text(
                          ' - ',
                          style: ZeplinTextStyles.CalendarDayBlack,
                        ),
                        Text(
                          DateFormat('hh:mm').format(events[index].terminBis),
                          style: ZeplinTextStyles.CalendarDayBlack,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 11, left: 11),
                    child: Text(events[index].titel),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
