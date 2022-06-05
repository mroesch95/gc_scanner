// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

List<Events> eventsFromJson(String str) =>
    List<Events>.from(json.decode(str).map((x) => Events.fromJson(x)));

String eventsToJson(List<Events> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Events {
  Events({
    required this.id,
    required this.titel,
    required this.terminVon,
    required this.terminBis,
    required this.imageUrl,
    required this.anzahlGesamtTickets,
    required this.anzahlTicketkaufOnline,
    required this.anzahlTicketkaufKasse,
    required this.gaesteAktuell,
  });

  int id;
  String titel;
  DateTime terminVon;
  DateTime terminBis;
  String imageUrl;
  int anzahlGesamtTickets;
  int anzahlTicketkaufOnline;
  int anzahlTicketkaufKasse;
  int gaesteAktuell;

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        id: json["id"],
        titel: json["titel"],
        terminVon: DateTime.parse(json["terminVon"]),
        terminBis: DateTime.parse(json["terminBis"]),
        imageUrl: json["imageUrl"],
        anzahlGesamtTickets: json["anzahlGesamtTickets"],
        anzahlTicketkaufOnline: json["anzahlTicketkaufOnline"],
        anzahlTicketkaufKasse: json["anzahlTicketkaufKasse"],
        gaesteAktuell: json["gaesteAktuell"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "terminVon": terminVon.toIso8601String(),
        "terminBis": terminBis.toIso8601String(),
        "imageUrl": imageUrl,
        "anzahlGesamtTickets": anzahlGesamtTickets,
        "anzahlTicketkaufOnline": anzahlTicketkaufOnline,
        "anzahlTicketkaufKasse": anzahlTicketkaufKasse,
        "gaesteAktuell": gaesteAktuell,
      };
}
