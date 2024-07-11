import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:user_listing_app/domain/entities/user.dart';
import 'package:user_listing_app/domain/usecases/GetUsers.dart';

import '../../data/models/UserModel.dart';

part 'UserEvent.dart';
part 'UserState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  late PagingController<int, UserModel> pagingController;

  UserBloc(this.getUsers) : super(UserInitial()) {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      add(FetchUsers(pageKey));
    });

    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      final users = await getUsers(event.page);
      final isLastPage = users.isEmpty;
      if (isLastPage) {
        pagingController.appendLastPage(users);
      } else {
        final nextPageKey = event.page + 1;
        pagingController.appendPage(users, nextPageKey);
      }
    } catch (_) {
      pagingController.error = Exception('Failed to fetch users');
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
