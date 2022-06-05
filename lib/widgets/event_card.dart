import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scanner/models/event.dart';
import 'package:scanner/pages/scan_page.dart';
import 'package:scanner/theme/zeplin_colors.dart';
import 'package:scanner/theme/zeplin_text_style.dart';
import 'package:scanner/widgets/scan_button.dart';

import 'package:pie_chart/pie_chart.dart';

class EventCard extends StatelessWidget {
  Event event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    print('Test Images = ' + event.imageUrl);
    return Container(
      color: ZeplinColors.scaffold_background,
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 84, left: 30, right: 30),
                  child: InkWell(
                    onTap: () => _popupDialogWithData(context),
                    child: Container(
                      height: 332,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(event.imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        ),
                      ),
                      child: buildPadding(),
                    ),
                  )),
            ],
          ),
          ScanButton()
        ],
      ),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.only(top: 255, left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24,
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(event.terminVon),
                style: ZeplinTextStyles.CalendarDayWhite,
              ),
              Expanded(child: Container()),
              const Icon(
                Icons.access_time,
                color: Colors.white,
                size: 24,
              ),
              Text(
                DateFormat('hh:mm').format(event.terminVon),
                style: ZeplinTextStyles.CalendarDayWhite,
              ),
              Text(
                ' - ',
                style: ZeplinTextStyles.CalendarDayWhite,
              ),
              Text(
                DateFormat('hh:mm').format(event.terminBis),
                style: ZeplinTextStyles.CalendarDayWhite,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Text(
                  event.titel.toUpperCase(),
                  style: ZeplinTextStyles.HeadlineSecondaryWhite20SP,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _popupDialogWithData(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          double anzahlGesamtTickets = event.anzahlGesamtTickets.toDouble();
          double anzahlTicketKaufOnline =
              event.anzahlTicketkaufOnline.toDouble();
          double anzahlTicketKaufKasse = event.anzahlTicketkaufKasse.toDouble();
          double gaesteAktuell = event.gaesteAktuell.toDouble();

          double freieTickets = (anzahlGesamtTickets -
              (anzahlTicketKaufOnline + anzahlTicketKaufKasse));

          double verkaufteTickets =
              anzahlTicketKaufOnline + anzahlTicketKaufKasse;

          Map<String, double> ticketsPie = {
            "verkaufte Tickets":
                verkaufteTickets, // (anzahlTicketKaufOnline + anzahlTicketKaufKasse)
            "freie Tickets":
                freieTickets, // (anzahlGesamtTickets - (anzahlTicketKaufOnline + anzahlTicketKaufKasse)
          };

          Map<String, double> gaestePie = {
            "Tickets gesamt": anzahlGesamtTickets,
            "Gäste aktuell": gaesteAktuell
          };
          return Padding(
            padding: EdgeInsets.only(top: 100, left: 17, right: 17, bottom: 99),
            child: Container(
              width: 326,
              height: 441,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 16, right: 81.8, bottom: 5),
                          child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.close))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 28),
                    child: Text(event.titel,
                        style: ZeplinTextStyles.HeadlinePrimaryBlue24SP),
                  ),

                  const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Besucher aktuell',
                      )),
                  PieChart(
                    dataMap: ticketsPie,
                    chartRadius: MediaQuery.of(context).size.width / 4.5,
                    legendOptions: LegendOptions(
                        showLegends: true,
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom),
                    chartValuesOptions:
                        ChartValuesOptions(showChartValuesInPercentage: true),
                    chartLegendSpacing: 1.5,
                  ),

                  const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Gäste aktuell',
                      )),
                  PieChart(
                    dataMap: gaestePie,
                    chartRadius: MediaQuery.of(context).size.width / 4.5,
                    legendOptions: LegendOptions(
                        showLegends: true,
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom),
                    chartValuesOptions:
                        ChartValuesOptions(showChartValuesInPercentage: true),
                    chartLegendSpacing: 1.5,
                  ),
                  //Gaeste_pie_chart(),
                ],
              ),
            ),
          );
        });
  }
}
