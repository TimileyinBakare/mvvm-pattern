import 'package:flutter/material.dart';
import 'package:mvvm/users_list/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = context.watch<ViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(" Address:${viewModel.selectedUser!.address!.city}"),
        centerTitle: true,
        backgroundColor: ThemeData.light().primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.selectedUser!.name!),
            Text(viewModel.selectedUser!.company!.name!)
          ],
        ),
      ),
    );
  }
}
