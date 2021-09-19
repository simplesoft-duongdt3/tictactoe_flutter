part of 'tictactoe_bloc.dart';

@immutable
abstract class TictactoeEvent {}

class TictactoePlayerEvent extends TictactoeEvent {
  final int idCell;

  TictactoePlayerEvent(this.idCell) : super();
}

class TictactoeResetGameEvent extends TictactoeEvent {
  TictactoeResetGameEvent() : super();
}
