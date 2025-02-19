import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tactix_academy_admin/Features/Home/domain/entities/home_details.dart';
import 'package:tactix_academy_admin/Features/Home/domain/usecases/home_use_case.dart';

part 'home_screen_datas_event.dart';
part 'home_screen_datas_state.dart';

class HomeScreenDatasBloc
    extends Bloc<HomeScreenDatasEvent, HomeScreenDatasState> {
  final HomeUseCase homeUseCase;

  HomeScreenDatasBloc(this.homeUseCase) : super(HomeScreenDatasInitial()) {
    on<LoadHomeScreenData>(_onLoadHomeScreenData);
  }

  Future<void> _onLoadHomeScreenData(
    LoadHomeScreenData event,
    Emitter<HomeScreenDatasState> emit,
  ) async {
    emit(HomeScreenDatasLoading());
    try {
      final homeDetails = await homeUseCase.callGetHomeDetails();
      emit(HomeScreenDatasLoaded(homeDetails));
    } catch (e) {
      emit(HomeScreenDatasError(e.toString()));
    }
  }
}
