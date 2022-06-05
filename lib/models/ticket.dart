import 'dart:convert';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    required this.ticketId,
    required this.qrCode,
    required this.ticketScanned,
    required this.eventId,
  });

  int ticketId;
  String qrCode;
  int ticketScanned;
  int eventId;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
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
