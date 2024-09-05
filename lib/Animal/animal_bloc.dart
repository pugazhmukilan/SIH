import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  AnimalBloc() : super(AnimalInitial()) {
    on<AnimalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
