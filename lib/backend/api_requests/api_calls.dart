import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class IssueTicketCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
  }) {
    final body = '''
{

"name": "DEMOMAN",

"address": "1737 Grafton St, Halifax, NS B3J 2C6, Cansada",
"timezone": "UTC"

}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Issue Ticket',
      apiUrl: 'https://api.pub1.passkit.io/eventTickets/venue',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${jwt}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class EventTicketsticketredeemCall {
  static Future<ApiCallResponse> call() {
    final body = '''
{
  "ticket": {
    "ticketId": "string",
    "ticketNumber": {
      "productionId": "string",
      "ticketNumber": "string"
    }
  },
  "redemptionDetails": {
    "redemptionDate": "2022-07-09T06:31:37Z",
    "lat": 0,
    "lon": 0,
    "alt": 0,
    "redemptionSource": "string",
    "redemptionReference": "string"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'eventTicketsticketredeem',
      apiUrl: 'https://api.pub1.passkit.io/eventTickets/ticket/redeem',
      callType: ApiCallType.PUT,
      headers: {
        'ContentType': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class CreateVenueCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
    String? pkApiSecret = '',
    String? pkApiKey = '',
  }) {
    final body = '''

{

"name": "DEMOMAN",

"address": "1737 Grafton St, Halifax, NS B3J 2C6, Cansada",
"timezone": "UTC"

}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateVenue',
      apiUrl: 'https://api.pub1.passkit.io/eventTickets/venue',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'Content-Type',
        'Authorization': '${jwt}',
      },
      params: {
        'PK_API_SECRET': pkApiSecret,
        'PK_API_KEY': pkApiKey,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}
