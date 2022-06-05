class EventBeans {
  int id;
  String titel;
  String terminVon;
  String terminBis;
  String imageUrl;
  int anzahlGesamtTickets;
  int anzahlTicketkaufOnline;
  int anzahlTicketkaufKasse;
  int gaesteAktuell;

  EventBeans(
      {required this.id,
      required this.titel,
      required this.terminVon,
      required this.terminBis,
      required this.imageUrl,
      required this.anzahlGesamtTickets,
      required this.anzahlTicketkaufOnline,
      required this.anzahlTicketkaufKasse,
      required this.gaesteAktuell});

  factory EventBeans.fromJson(Map<String, dynamic> json) {
    return EventBeans(
        id: json['id'] as int,
        titel: json['titel'] as String,
        terminVon: json['terminVon'] as String,
        terminBis: json['terminBis'] as String,
        imageUrl: json['imageUrl'] as String,
        anzahlGesamtTickets: json['anzahlGesamtTickets'] as int,
        anzahlTicketkaufOnline: json['anzahlTicketkaufOnline'] as int,
        anzahlTicketkaufKasse: json['anzahlTicketkaufKasse'] as int,
        gaesteAktuell: json['gaesteAktuell'] as int);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "terminvon": terminVon,
        "terminbis": terminBis,
        "imageurl": imageUrl,
        "anzahlgesamttickets": anzahlGesamtTickets,
        "anzahlticketkaufonline": anzahlTicketkaufOnline,
        "anzahlTicketkaufKasse": anzahlTicketkaufKasse,
        "gaesteaktuell": gaesteAktuell,
      };
}
