import 'package:flutter/material.dart';
import 'package:mvvm/users_list/models/user_list_error.dart';
import 'package:mvvm/users_list/models/user_list_model.dart';
import 'package:mvvm/users_list/repo/api_status.dart';
import 'package:mvvm/users_list/repo/user_services.dart';

class ViewModel extends ChangeNotifier {
  ViewModel() {
    getUsers();
  }
  bool _loading = false;
  UserError? _userError;
  UserModel? _selectUser;
  List<UserModel> _userListModel = [];

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setError(UserError userError) {
    _userError = userError;
  }

  setUser(UserModel userModel) {
    _selectUser = userModel;
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  bool get loading {
    return _loading;
  }

  List<UserModel> get userListModel {
    return _userListModel;
  }

  UserError? get userError {
    return _userError;
  }

  UserModel? get selectedUser {
    return _selectUser;
  }

  getUsers() async {
    setLoading(true);
    var data = await UserServices.getUsers();
    if (data is Success) {
      setUserListModel(data.response as List<UserModel>);
    }
    if (data is Failure) {
      UserError? userError = UserError(
        code: data.code.toString(),
        message: data.errorResponse,
      );
      setError(userError);
    }
    setLoading(false);
  }
}
