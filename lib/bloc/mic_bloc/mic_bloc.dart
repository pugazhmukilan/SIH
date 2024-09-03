import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mic_event.dart';
part 'mic_state.dart';

class MicBloc extends Bloc<MicEvent, MicState> {
  MicBloc() : super(MicInitial()) {
    on<ListenNow>((event, emit) {
      // TODO: implement event handler
      emit((Listening()));
    });

    on<StopListening>((event, emit) {
      // TODO: implement event handler
      emit((MicInitial()));
    });
  }
}
