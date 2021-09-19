class TicTacToeManager {
  List<List<int>> _board =
      List<List<int>>.generate(3, (_) => [0, 0, 0], growable: false);
  Player _currentPlayer = Player.NoOne;

  void play(int idCell) {
    int row = idCell ~/ 10;
    int col = idCell % 10;
    if (_board[row][col] == 0) {
      Player nextPlayer = Player.Player1;
      if (_currentPlayer == Player.Player1) {
        nextPlayer = Player.Player2;
      } else {
        nextPlayer = Player.Player1;
      }

      int cellValue = 1;
      if (nextPlayer == Player.Player2) {
        cellValue = 2;
      }

      _board[row][col] = cellValue;
      _currentPlayer = nextPlayer;
    }
  }

  Board getBoard() {
    List<BoardCell> boardCells = [
      _buildBoardCell(0, _board[0][0]),
      _buildBoardCell(1, _board[0][1]),
      _buildBoardCell(2, _board[0][2]),
      _buildBoardCell(10, _board[1][0]),
      _buildBoardCell(11, _board[1][1]),
      _buildBoardCell(12, _board[1][2]),
      _buildBoardCell(20, _board[2][0]),
      _buildBoardCell(21, _board[2][1]),
      _buildBoardCell(22, _board[2][2]),
    ];
    Winner currentWinner = findWinner();
    Player nextPlayer = Player.Player1;
    if (_currentPlayer == Player.Player1) {
      nextPlayer = Player.Player2;
    } else {
      nextPlayer = Player.Player1;
    }
    return Board(boardCells, currentWinner, nextPlayer);
  }

  bool _checkHaveEmptyCell() {
    bool isHaveEmptyCell = false;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == 0) {
          isHaveEmptyCell = true;
          break;
        }
      }

      if (isHaveEmptyCell) {
        break;
      }
    }
    return isHaveEmptyCell;
  }

  Winner findWinner() {
    int winner = 0;
    if (_board[0][0] == _board[0][1] &&
        _board[0][0] == _board[0][2] &&
        _board[0][0] != 0) {
      winner = _board[0][0];
    } else if (_board[1][0] == _board[1][1] &&
        _board[1][0] == _board[1][2] &&
        _board[1][0] != 0) {
      winner = _board[1][0];
    } else if (_board[2][0] == _board[2][1] &&
        _board[2][0] == _board[2][2] &&
        _board[2][0] != 0) {
      winner = _board[2][0];
    } else if (_board[0][0] == _board[1][0] &&
        _board[0][0] == _board[2][0] &&
        _board[0][0] != 0) {
      winner = _board[0][0];
    } else if (_board[0][1] == _board[1][1] &&
        _board[0][1] == _board[2][1] &&
        _board[0][1] != 0) {
      winner = _board[0][1];
    } else if (_board[0][2] == _board[1][2] &&
        _board[0][2] == _board[2][2] &&
        _board[0][2] != 0) {
      winner = _board[0][2];
    } else if (_board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2] &&
        _board[0][0] != 0) {
      winner = _board[0][0];
    } else if (_board[2][0] == _board[1][1] &&
        _board[2][0] == _board[0][2] &&
        _board[2][0] != 0) {
      winner = _board[2][0];
    }

    if (winner == 0) {
      bool isHaveEmptyCell = _checkHaveEmptyCell();
      if (!isHaveEmptyCell) {
        winner = 3;
      }
    }

    if (winner == 0) {
      return Winner.NoOne;
    } else if (winner == 1) {
      return Winner.Player1;
    } else if (winner == 2) {
      return Winner.Player2;
    } else {
      return Winner.Draw;
    }
  }

  BoardCell _buildBoardCell(int id, int boardCellValue) {
    Player player = Player.NoOne;
    if (boardCellValue == 1) {
      player = Player.Player1;
    } else if (boardCellValue == 2) {
      player = Player.Player2;
    }

    return BoardCell(
      id,
      player,
    );
  }

  void resetGame() {
    _board = List<List<int>>.generate(3, (_) => [0, 0, 0], growable: false);
    _currentPlayer = Player.NoOne;
  }
}

enum Winner {
  Player1,
  Player2,
  NoOne,
  Draw,
}

enum Player { Player1, Player2, NoOne }

class Board {
  final List<BoardCell> boardCells;
  final Winner currentWinner;
  final Player nextPlayer;

  Board(this.boardCells, this.currentWinner, this.nextPlayer);
}

class BoardCell {
  final int id;
  final Player player;

  BoardCell(this.id, this.player);
}
