abstract class HomeEvent {}

class IndexChanged extends HomeEvent {
  final int index;
  IndexChanged(this.index);
}
