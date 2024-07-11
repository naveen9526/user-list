part of 'UserBloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;

  FetchUsers(this.page);

  @override
  List<Object> get props => [page];
}
