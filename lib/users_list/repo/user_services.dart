import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mvvm/users_list/repo/api_status.dart';
import 'package:mvvm/utils/constants.dart';

import '../models/user_list_model.dart';

class UserServices {
  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final userModel = userModelFromJson(response.body);
        return Success(code: response.statusCode, response: userModel);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");
    }
  }
}