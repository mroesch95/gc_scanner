import 'dart:convert';

import 'package:http/http.dart';

import '../constants/strings.dart';
import '../models/tickets.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class TicketsService extends ApiBaseService {
  Future<List<Tickets>> getTickets() async {
    dynamic ticketsListJson = await getData(Strings.tickets_url);
    final List<Tickets> tickets = ticketsFromJson(ticketsListJson);
    print(tickets);
    return tickets;
  }

  Future<void> updateTicket(int ticketId) async {
    final url = Uri.parse(Strings.update_Ticket);
    final headers = {"Content-type": "application/json"};
    final json = {"ticketId": ticketId, "ticketScanned": 1};
    final response = await patch(url, headers: headers, body: jsonEncode(json));
    print(ticketId);
    print('Status code: ${response.statusCode}');
  }
}
