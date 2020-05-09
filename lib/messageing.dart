import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAA7mRLJEI:APA91bGS7Wz2m_qyyRlDNNU-xxL7qCisvvwJg74DjIp_zsvxFHh219m7DB0lzZ-27_lt6qsv0nk52NfuRFpyQ00tdtSUrshr8vHFUbq0__OL_-pfEi3S5xeXGw66czmpDIaXjhZ0bxGe';
 static const String anu = 'fYlysQdzaa0:APA91bFzSpGpR9BQGOaLBR-TlvmnbiTycGDzsuWph2iBAhSuUAU78-ooYuQnna9qQjwEfaaq4mZKfTFzptrNFCmjLF9b52b4V1ivhsGYVg6mB6tagp8JWrHbqFV28zlHu0x-oqcrZukh';
  static const String poco = 'cyjCDV6PNaU:APA91bFhh10Xw7OLoegCphDZ_rI50e6i03FTfd0m4ZI11LZgT5mBSpuxZy_8T6SdWD-ZrtgiGcc8j2njw9yz6tfmKuj_ohlQnlNQ0KzELqMIfPsjEjFAVTI1qoYhe7WUyeqYSBglbgLM';
  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: '$anu');

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}