class TicketBeans {
  int ticketId, eventId;
  String qrCode;
  int ticketScanned;

  TicketBeans(
      {required this.ticketId,
      required this.qrCode,
      required this.ticketScanned,
      required this.eventId});

  factory TicketBeans.fromJson(Map<String, dynamic> json) {
    return TicketBeans(
        ticketId: json['ticketId'] as int,
        qrCode: json['qrCode'] as String,
        ticketScanned: json['ticketScanned'] as int,
        eventId: json['eventId'] as int);
  }

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "qrCode": qrCode,
        "ticketScanned": ticketScanned,
        "eventId": eventId
      };
}
