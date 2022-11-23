part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}


class MapLoding extends MapState {}

class MapSuccess extends MapState {
  final List<MarkerModel> marker;
  const MapSuccess(this.marker);

  @override
  List<Object> get props => [marker];
}

class AuthFailed extends MapState {
  final String error;
  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
