import 'package:http/http.dart' as http;
import 'package:phone_book/constants.dart';

Future<http.Response> getContacts() async {
  Future<http.Response> response = http.post(
      Uri.parse(
        '$kUrl/contacts',
      ),
      headers: {});
  return response;
}

Future<http.Response> delete({
  required String uid,
}) async {
  Future<http.Response> response = http.post(
    Uri.parse(
      '$kUrl/delete',
    ),
    body: {
      'uid': uid,
    },
  );
  return response;
}

Future<http.Response> add({
  required String uid,
  required String name,
  required String number,
}) async {
  Future<http.Response> response = http.post(
    Uri.parse(
      '$kUrl/add',
    ),
    body: {
      'uid': uid,
      'name': name,
      'number': number,
    },
  );
  return response;
}

Future<http.Response> edit({
  required String uid,
  required String name,
  required String number,
}) async {
  Future<http.Response> response = http.post(
    Uri.parse(
      '$kUrl/edit',
    ),
    body: {
      'uid': uid,
      'name': name,
      'number': number,
    },
  );
  return response;
}
