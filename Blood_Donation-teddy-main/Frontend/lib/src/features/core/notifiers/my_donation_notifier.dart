import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';
import 'package:flutter_application_1/src/features/core/states/my_donation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDonationNotifier extends StateNotifier<MyDonationState> {
  MyDonationNotifier(this._apiService)
      : super(MyDonationState(
            bloodRequests: [], hasNext: true, isLoading: false));
  final ApiService _apiService;
  int page = 1;

  Future<void> getMyDonation() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );

    final bloodRequest = await _apiService.getMyDonation();
    final newbloodRequest = [...state.bloodRequests, ...bloodRequest!];
    if (bloodRequest.length % 10 != 0 || bloodRequest.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(
      const Duration(microseconds: 1500),
      () {
        state = state.copyWith(bloodRequests: newbloodRequest);
        page++;
      },
    );
    state = state.copyWith(isLoading: false);
  }
}
