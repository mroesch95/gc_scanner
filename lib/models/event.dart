import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) => Event(
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
