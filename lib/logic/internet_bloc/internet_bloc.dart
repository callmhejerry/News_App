import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/logic/internet_bloc/internet_event.dart';
import 'package:news_app/logic/internet_bloc/internet_state.dart';
import 'package:news_app/utils/internet_checker.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetConnection internetConnection;
  late StreamSubscription internetSubscription;
  InternetBloc({required this.internetConnection})
      : super(InternetState(status: InternetStatus.none)) {
    on<NotConnected>((event, emit) {
      emit(InternetState(status: InternetStatus.disconnected));
    });
    internetSubscription = internetConnection.connection.listen((event) {
      if ((event != ConnectivityResult.mobile) ||
          (event != ConnectivityResult.wifi) ||
          (event != ConnectivityResult.ethernet) ||
          (event == ConnectivityResult.none)) {
        add(NotConnected());
      }
    });
  }

  @override
  Future<void> close() {
    internetSubscription.cancel();
    return super.close();
  }
}
