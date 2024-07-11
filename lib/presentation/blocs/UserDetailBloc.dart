import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_listing_app/domain/entities/user.dart';
import 'package:user_listing_app/data/repositories/UserRepository.dart';

part 'UserDetailEvent.dart';
part 'UserDetailState.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository userRepository;

  UserDetailBloc(this.userRepository) : super(UserDetailInitial()) {
    on<FetchUserDetail>(_onFetchUserDetail);
  }

  void _onFetchUserDetail(FetchUserDetail event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoading());
    try {
      final user = await userRepository.fetchUserDetail(event.userId);
      emit(UserDetailLoaded(user: User(
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        avatar: user.avatar,
      )));
    } catch (_) {
      emit(UserDetailError('Failed to load user detail'));
    }
  }
}
