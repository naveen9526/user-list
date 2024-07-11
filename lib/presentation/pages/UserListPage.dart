import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:user_listing_app/data/models/UserModel.dart';
import 'package:user_listing_app/presentation/blocs/UserBloc.dart';
import 'package:user_listing_app/presentation/widgets/UserCard.dart';

import '../../data/repositories/UserRepository.dart';
import '../../domain/usecases/GetUsers.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List', style: TextStyle(
          fontFamily: 'SFProText',
          fontWeight: FontWeight.w300,
        )),
      ),
      body: BlocProvider(
        create: (context) => UserBloc(GetUsers(UserRepository())),
        child: UserListView(),
      ),
    );
  }
}

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return PagedListView<int, UserModel>(
          pagingController: _userBloc.pagingController,
          builderDelegate: PagedChildBuilderDelegate<UserModel>(
            itemBuilder: (context, user, index) => UserCard(user: user),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Text('Error loading users'),
            ),
            noItemsFoundIndicatorBuilder: (context) => Center(
              child: Text('No users found'),
            ),
            newPageProgressIndicatorBuilder: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
