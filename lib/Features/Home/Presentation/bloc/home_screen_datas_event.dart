part of 'home_screen_datas_bloc.dart';

sealed class HomeScreenDatasEvent extends Equatable {
  const HomeScreenDatasEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch home screen data
class LoadHomeScreenData extends HomeScreenDatasEvent {}
