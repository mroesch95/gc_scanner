part of 'ticket_cubit.dart';

class TicketState {}

class TicketInitial extends TicketState {
  TicketInitial();
}

class TicketSuccess extends TicketState {
  TicketSuccess();
}

class TicketAlreadyScanned extends TicketState {
  TicketAlreadyScanned();
}

class TicketNotFound extends TicketState {
  TicketNotFound();
}
