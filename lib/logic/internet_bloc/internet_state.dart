class InternetState {
  InternetState({required this.status});
  late InternetStatus status;
}

enum InternetStatus { connected, disconnected, none }
