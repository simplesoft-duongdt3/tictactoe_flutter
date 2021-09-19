import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tictactoe_flutter/tictactoe/logic/manager/tictactoe_manager.dart';

part 'tictactoe_event.dart';
part 'tictactoe_state.dart';

class TictactoeBloc extends Bloc<TictactoeEvent, TictactoeState> {
  TicTacToeManager _ticTacToeManager;

  TictactoeBloc(this._ticTacToeManager)
      : super(TictactoeState(_ticTacToeManager.getBoard()));

  @override
  Stream<TictactoeState> mapEventToState(
    TictactoeEvent event,
  ) async* {
    if (event is TictactoePlayerEvent) {
      yield* _handleTictactoePlayerEvent(event);
    } else if (event is TictactoeResetGameEvent) {
      yield* _handleTictactoeResetGameEvent();
    }
  }

  Stream<TictactoeState> _handleTictactoePlayerEvent(
      TictactoePlayerEvent event) async* {
    _ticTacToeManager.play(event.idCell);
    Board board = _ticTacToeManager.getBoard();
    yield TictactoeState(board);
  }

  Stream<TictactoeState> _handleTictactoeResetGameEvent() async* {
    _ticTacToeManager.resetGame();
    Board board = _ticTacToeManager.getBoard();
    yield TictactoeState(board);
  }
}
