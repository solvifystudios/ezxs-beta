import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class IssueTicketCall {
  static Future<ApiCallResponse> call() {
    final body = '''
{
"ticketNumber": "string",
 "ticketTypeId": "1thBDl7i3uU20AIRAzWeeY",
    "event": {
    "id": "0WLOYZqeaLNE19klAKYPBO",

        "production": {
            "venueid": "5CI7iR9dDgrJT5COmptlPN",
        "uid": "533O9lWjKyIbD5ANsiO0UF",
        "name": "EZXS ALL ACCESS"
        },

        "venue": {

           

        "uid": "string",
        "name": "Hide n Seek",
        "address": "1737 Grafton St, Halifax, NS B3J 2C6, Canada"

        }
    }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Issue Ticket',
      apiUrl: 'https://api.pub1.passkit.io/eventTickets/ticket/id',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'pm.enviornment.jwt',
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
