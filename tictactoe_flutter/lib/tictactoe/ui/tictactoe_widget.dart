import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_flutter/tictactoe/logic/bloc/tictactoe_bloc.dart';
import 'package:tictactoe_flutter/tictactoe/logic/manager/tictactoe_manager.dart';

class TicTacToeWiget extends StatelessWidget {
  const TicTacToeWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: BlocProvider(
        create: (context) => TictactoeBloc(TicTacToeManager()),
        child: _buildBoard(),
      ),
    );
  }

  Widget _buildBoard() {
    return BlocBuilder<TictactoeBloc, TictactoeState>(
      builder: (context, state) {
        return Builder(builder: (context) {
          return Center(
            child: _buildBoardCells(context, state),
          );
        });
      },
    );
  }

  Widget _buildBoardCells(BuildContext context, TictactoeState state) {
    Widget playerWin = Container();
    var winner = state.board.currentWinner;
    bool isGameDone = winner != Winner.NoOne;
    if (isGameDone) {
      if (winner == Winner.Player1) {
        playerWin = Text(
          "Player 1 win!",
          style: TextStyle(
            fontSize: 45,
            color: Colors.red,
          ),
        );
      } else if (winner == Winner.Player2) {
        playerWin = Text(
          "Player 2 win!",
          style: TextStyle(
            fontSize: 45,
            color: Colors.green,
          ),
        );
      } else if (winner == Winner.Draw) {
        playerWin = Text(
          "Draw!",
          style: TextStyle(
            fontSize: 45,
            color: Colors.brown,
          ),
        );
      }
    }

    Widget resetGameBt = Container();
    if (state.board.currentWinner != Winner.NoOne) {
      resetGameBt = TextButton(
        onPressed: () {
          BlocProvider.of<TictactoeBloc>(context)
              .add(TictactoeResetGameEvent());
        },
        child: Text(
          "Reset game",
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        playerWin,
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buidBoardCell(context, state.board.boardCells[0],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[1],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[2],
                state.board.nextPlayer, isGameDone),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buidBoardCell(context, state.board.boardCells[3],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[4],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[5],
                state.board.nextPlayer, isGameDone),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buidBoardCell(context, state.board.boardCells[6],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[7],
                state.board.nextPlayer, isGameDone),
            _buidBoardCell(context, state.board.boardCells[8],
                state.board.nextPlayer, isGameDone),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        resetGameBt,
      ],
    );
  }

  Widget _buidBoardCell(
    BuildContext context,
    BoardCell boardCell,
    Player nextPlayer,
    bool isGameDone,
  ) {
    Player player = boardCell.player;
    int idCell = boardCell.id;

    Widget btPlayer1 = Icon(
      Icons.close,
      color: Colors.red,
      size: 70,
    );

    Widget btPlayer2 = Icon(
      Icons.circle_outlined,
      color: Colors.green,
      size: 60,
    );

    IconButton btPlayerNoOneNext1 = IconButton(
      onPressed: () {
        if (!isGameDone) {
          BlocProvider.of<TictactoeBloc>(context)
              .add(TictactoePlayerEvent(idCell));
        }
      },
      icon: Icon(
        Icons.close,
        color: Colors.white,
        size: 60,
      ),
    );

    IconButton btPlayerNoOneNext2 = IconButton(
      onPressed: () {
        if (!isGameDone) {
          BlocProvider.of<TictactoeBloc>(context)
              .add(TictactoePlayerEvent(idCell));
        }
      },
      icon: Icon(
        Icons.circle_outlined,
        color: Colors.white,
        size: 60,
      ),
    );

    Widget? btCell;
    if (player == Player.Player1) {
      btCell = btPlayer1;
    } else if (player == Player.Player2) {
      btCell = btPlayer2;
    } else {
      if (nextPlayer == Player.Player1) {
        btCell = btPlayerNoOneNext1;
      } else {
        btCell = btPlayerNoOneNext2;
      }
    }

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey.shade300),
      ),
      child: btCell,
    );
  }
}
