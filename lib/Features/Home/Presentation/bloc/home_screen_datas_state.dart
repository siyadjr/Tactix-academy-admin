part of 'home_screen_datas_bloc.dart';

sealed class HomeScreenDatasState extends Equatable {
  const HomeScreenDatasState();

  @override
  List<Object> get props => [];
}

/// Initial state
final class HomeScreenDatasInitial extends HomeScreenDatasState {}

/// Loading state
final class HomeScreenDatasLoading extends HomeScreenDatasState {}

/// Success state with data
final class HomeScreenDatasLoaded extends HomeScreenDatasState {
  final HomeDetails homeDetails;

  const HomeScreenDatasLoaded(this.homeDetails);

  @override
  List<Object> get props => [homeDetails];
}

/// Error state
final class HomeScreenDatasError extends HomeScreenDatasState {
  final String message;

  const HomeScreenDatasError(this.message);

  @override
  List<Object> get props => [message];
}
