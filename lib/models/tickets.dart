import 'dart:convert';

List<Tickets> ticketsFromJson(String str) =>
    List<Tickets>.from(json.decode(str).map((x) => Tickets.fromJson(x)));

String ticketsToJson(List<Tickets> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tickets {
  Tickets({
    required this.ticketId,
    required this.qrCode,
    required this.ticketScanned,
    required this.eventId,
  });

  int ticketId;
  String qrCode;
  int ticketScanned;
  int eventId;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        ticketId: json["ticketId"],
        qrCode: json["qrCode"],
        ticketScanned: json["ticketScanned"],
        eventId: json["eventId"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "qrCode": qrCode,
        "ticketScanned": ticketScanned,
        "eventId": eventId,
      };
}
