import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter XO Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: XOGame(),
    );
  }
}

class XOGame extends StatefulWidget {
  @override
  _XOGameState createState() => _XOGameState();
}

class _XOGameState extends State<XOGame> {
  List<String> _board = List.filled(9, '');
  bool _isXTurn = true;
  String _winner = '';

  void _handleTap(int index) {
    if (_board[index] == '' && _winner == '') {
      setState(() {
        _board[index] = _isXTurn ? 'X' : 'O';
        _isXTurn = !_isXTurn;
        _winner = _checkWinner();
      });
    }
  }

  String _checkWinner() {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var line in lines) {
      if (_board[line[0]] != '' &&
          _board[line[0]] == _board[line[1]] &&
          _board[line[1]] == _board[line[2]]) {
        return _board[line[0]];
      }
    }

    if (!_board.contains('')) {
      return 'Draw';
    }

    return '';
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _isXTurn = true;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XO Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _winner == ''
                ? 'Turn: ${_isXTurn ? 'X' : 'O'}'
                : _winner == 'Draw'
                    ? 'Game Draw'
                    : 'Winner: $_winner',
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    margin: EdgeInsets.all(2.0),
                    padding: EdgeInsets.all(4.0),
                    constraints: BoxConstraints(
                      minWidth: 40.0,
                      minHeight: 40.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.blueAccent,
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
