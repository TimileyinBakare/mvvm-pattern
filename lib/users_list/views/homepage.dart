import 'package:flutter/material.dart';
import 'package:mvvm/users_list/models/user_list_model.dart';
import 'package:mvvm/users_list/view_models/user_view_model.dart';
import 'package:mvvm/users_list/views/userdetailsscreen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = context.watch<ViewModel>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _body(viewModel),
        ],
      ),
    );
  }

  _body(ViewModel viewModel) {
    if (viewModel.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.userError != null) {
      return Center(
        child: Text(viewModel.userError!.message.toString()),
      );
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = viewModel.userListModel[index];
          return InkWell(
            onTap: () {
              viewModel.setUser(userModel);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const UserDetailScreen();
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(userModel.name!),
                  Text(userModel.email!),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: viewModel.userListModel.length,
      ),
    );
  }
}
