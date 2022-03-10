import 'package:flutter/material.dart';

enum CardStatus { like, dislike }

class CardProvider extends ChangeNotifier {
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 20 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition(DragEndDetails details) {
    _isDragging = false;
    notifyListeners();

    final status = getStatus();

    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      default:
        resetPosition();
        break;
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = position.dx;

    final delta = 100;

    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    }
    return null;
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);

    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _position += Offset(-(2 * _screenSize.width), 0);

    notifyListeners();
  }

  // Future<void> _nextCard() async {

  // }
}
