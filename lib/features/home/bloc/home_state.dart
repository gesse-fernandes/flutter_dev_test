class HomeState {
  final int index;

  HomeState({required this.index});

  factory HomeState.initial() => HomeState(index: 0);

  HomeState copyWith({int? index}) {
    return HomeState(index: index ?? this.index);
  }
}
