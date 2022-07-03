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

// Future<http.Response> getContacts({
//   required String state,
// }) async {
//   Future<http.Response> response = http.delete(
//     Uri.parse(
//       '$kUrl/deleteUser/',
//     ),
//     body: {
//       'state': state,
//     },
//   );
//   return response;
// }

// Future<http.Response> getContacts({
//   required String state,
// }) async {
//   Future<http.Response> response = http.delete(
//     Uri.parse(
//       '$kUrl/deleteUser/',
//     ),
//     body: {
//       'state': state,
//     },
//   );
//   return response;
// }

// Future<http.Response> getContacts({
//   required String state,
// }) async {
//   Future<http.Response> response = http.delete(
//     Uri.parse(
//       '$kUrl/deleteUser/',
//     ),
//     body: {
//       'state': state,
//     },
//   );
//   return response;
// }

// Future<http.Response> getContacts({
//   required String state,
// }) async {
//   Future<http.Response> response = http.delete(
//     Uri.parse(
//       '$kUrl/deleteUser/',
//     ),
//     body: {
//       'state': state,
//     },
//   );
//   return response;
// }
