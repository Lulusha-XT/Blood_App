import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/states/my_request_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRequestsNotifier extends StateNotifier<MyRequestState> {
  MyRequestsNotifier(this._apiService)
      : super(MyRequestState(myRequests: [], hasNext: true, isLoading: false));
  final ApiService _apiService;

  int page = 1;

  Future<void> getMyRequests() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }

    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copywith(isLoading: true);
    });

    final myrequest = await _apiService.getMyRequest();
    final newRequest = [...state.myRequests, ...myrequest!];
    if (myrequest.length % 10 != 0 || myrequest.isEmpty) {
      state = state.copywith(hasNext: false);
    }

    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copywith(myRequest: newRequest);
      page++;
      state = state.copywith(isLoading: false);
    });
  }
}
