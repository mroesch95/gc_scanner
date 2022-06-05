import 'package:path/path.dart';
import 'package:scanner/db/config.dart';
import 'package:scanner/models/eventBeans.dart';
import 'package:scanner/models/ticketBeans.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDB {
  Future<Database> get database async {
    return await initializeDB();
  }

  Future<Database> initializeDB() async {
    var databsePath = await getDatabasesPath();
    String dbPath = join(databsePath.toString(), Config.dbName);
    return await openDatabase(dbPath, version: 1, onCreate: createTable);
  }

  createTable(Database database, int version) async {
    String createEventTable = "CREATE TABLE " +
        Config.eventTable +
        "(" +
        Config.eventId +
        " TEXT," +
        Config.eventTitle +
        " TEXT," +
        Config.eventTerminVon +
        " TEXT"
            "," +
        Config.eventTerminBis +
        " TEXT," +
        Config.eventImageUrl +
        " TEXT," +
        Config.eventAnzahlGesamtTickets +
        " INTEGER"
            "," +
        Config.eventAnzahlTicketkaufOnline +
        " INTEGER," +
        Config.eventAnzahlTicketkaufKasse +
        " INTEGER"
            "," +
        Config.eventGaesteAktuell +
        " INTEGER)";

    String createTicketTable = "CREATE TABLE " +
        Config.ticketTable +
        "(" +
        Config.ticketId +
        " INTEGER," +
        Config.ticketQrCode +
        " TEXT," +
        Config.ticketScanned +
        " INTEGER," +
        Config.ticketEventId +
        " INTEGER)";

    await database.execute(createEventTable);
    await database.execute(createTicketTable);
  }

  Future<int> insertEventRecord(EventBeans event) async {
    Database db = await database;
    int result = await db.insert(Config.eventTable, event.toJson());
    return result;
  }

  Future<int> updateEventDBOnline(EventBeans event) async {
    Database db = await database;
    int result = await db.update(Config.eventTable, event.toJson());
    print('update Event Online successful');

    return result;
  }

  Future<int> updateEventDBKasse(EventBeans event) async {
    Database db = await database;
    int result = await db.update(Config.eventTable, event.toJson());
    print('update Event Kasse successful');

    return result;
  }

  Future<List<EventBeans>> getEvents() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM ' + Config.eventTable);

    List<EventBeans> eventsList = [];
    if (result.isNotEmpty) {
      print('events not empty');
      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> list = result[i];
        int id = int.parse(list['id'].toString());
        String title = list['titel'];
        String terminVon = list['terminVon'];
        String terminBis = list['terminBis'];
        String imageUrl = list['imageUrl'];
        int anzahlGesamtTickets =
            int.parse(list['anzahlGesamtTickets'].toString());
        int anzahlTicketOnline =
            int.parse(list['anzahlTicketkaufOnline'].toString());
        int anzahlTicketKasse =
            int.parse(list['anzahlTicketkaufKasse'].toString());
        int gaesteAktuell = int.parse(list['gaesteAktuell'].toString());

        eventsList.add(EventBeans(
          id: id,
          titel: title,
          terminVon: terminVon,
          terminBis: terminBis,
          imageUrl: imageUrl,
          anzahlGesamtTickets: anzahlGesamtTickets,
          anzahlTicketkaufOnline: anzahlTicketOnline,
          anzahlTicketkaufKasse: anzahlTicketKasse,
          gaesteAktuell: gaesteAktuell,
        ));
      }

      return eventsList;
    } else {
      print('no events');
      return [];
    }
  }

  Future<List<EventBeans>> getEventById(id) async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM ' +
        Config.eventTable +
        " where " +
        Config.eventId +
        "=" +
        id.toString() +
        "");
    if (result.isNotEmpty) {
      print('not empty');
      List<EventBeans> eventsList =
          result.map((dynamic item) => EventBeans.fromJson(item)).toList();
      return eventsList;
    }
    return [];
  }

  deleteEvents() async {
    Database db = await database;
    await db.delete(Config.eventTable);
    print('events deleted');
  }

  Future<int> insertTicketRecord(TicketBeans ticket) async {
    Database db = await database;
    int result = await db.insert(Config.ticketTable, ticket.toJson());
    print('insert successful');
    return result;
  }

  Future<List<TicketBeans>> getTickets() async {
    Database db = await database;
    var result = await db.rawQuery('SELECT * FROM ' + Config.ticketTable);
    print(result);
    List<TicketBeans> ticketsList = [];
    if (result.isNotEmpty) {
      print('tickets not empty');
      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> list = result[i];
        int ticketId = int.parse(list['ticketId'].toString());
        String qrCode = list['qrCode'];

        int ticketScanned = int.parse(list['ticketScanned'].toString());

        int eventId = int.parse(list['eventId'].toString());
        ticketsList.add(TicketBeans(
            ticketId: ticketId,
            qrCode: qrCode,
            ticketScanned: ticketScanned,
            eventId: eventId));
      }

      return ticketsList;
    } else {
      print('no tickets');
    }
    return ticketsList;
  }

  Future<int> updateTicket(
    TicketBeans ticket,
  ) async {
    Database db = await database;
    int result = await db.update(Config.ticketTable, ticket.toJson());
    print('ticket update successful');
    return result;
  }

  deleteTickets() async {
    Database db = await database;
    await db.delete(Config.ticketTable);
    print('tickets deleted');
  }
}
