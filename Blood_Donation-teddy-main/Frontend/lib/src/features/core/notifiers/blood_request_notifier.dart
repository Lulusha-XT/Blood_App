import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/blood_request_model.dart';
import 'package:flutter_application_1/src/features/core/states/blood_request_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BloodRequestNotifier extends StateNotifier<BloodRequestState> {
  BloodRequestNotifier(this._apiService)
      : super(BloodRequestState(
            bloodRequests: [], hasNext: true, isLoading: false));
  final ApiService _apiService;
  int page = 1;

  Future<bool> createBloodRequest(
    BloodRequest bloodRequest,
  ) async {
    state = state.copyWith(isLoading: true);
    print('this is new blood request$bloodRequest');
    final result = await _apiService.createBloodeRequest(bloodRequest);
    final bloodRequests = await _apiService.getBloodRequest();
    final newbloodRequest = [...state.bloodRequests, ...bloodRequests!];
    print('this is new blood request$newbloodRequest');

    state = state.copyWith(
      bloodRequests: newbloodRequest,
      isLoading: false, // Set isLoading back to false
    );
    return result;
  }

  Future<void> getBloodRequest() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );

    final bloodRequest = await _apiService.getBloodRequest();
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

  Future<bool> updateBloodRequest(BloodRequest bloodRequest) async {
    final updatedUser = await _apiService.updateBloodRequest(bloodRequest);
    if (updatedUser) {
      final bloodRequests = await _apiService.getBloodRequest();
      state.bloodRequests = bloodRequests!;
      return true;
    }
    return false;
  }
}
