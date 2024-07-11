import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_listing_app/presentation/blocs/UserDetailBloc.dart';
import 'package:user_listing_app/data/repositories/UserRepository.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  const UserDetailPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail', style: TextStyle(
          fontFamily: 'SFProText',
          fontWeight: FontWeight.w300,
        )),
      ),
      body: BlocProvider(
        create: (context) => UserDetailBloc(UserRepository())..add(FetchUserDetail(userId)),
        child: UserDetailView(),
      ),
    );
  }
}

class UserDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserDetailLoaded) {
          final user = state.user;
          return Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                  radius: 50,
                ),
                SizedBox(height: 20),
                Text('${user.firstName} ${user.lastName}', style: const TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w300,
                )),
                Text(user.email, style: const TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w300,
                )),
              ],
            ),
          );
        } else if (state is UserDetailError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
