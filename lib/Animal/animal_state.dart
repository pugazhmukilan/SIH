part of 'animal_bloc.dart';

sealed class AnimalState extends Equatable {
  const AnimalState();
  
  @override
  List<Object> get props => [];
}

final class AnimalInitial extends AnimalState {}
