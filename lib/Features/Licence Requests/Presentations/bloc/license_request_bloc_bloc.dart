import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'license_request_bloc_event.dart';
part 'license_request_bloc_state.dart';

class LicenseRequestBlocBloc extends Bloc<LicenseRequestBlocEvent, LicenseRequestBlocState> {
  LicenseRequestBlocBloc() : super(LicenseRequestBlocInitial()) {
    on<LicenseRequestBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
