import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/sponser.dart';
import 'package:flutter_application_1/src/features/core/states/sponserstate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SponserNotifier extends StateNotifier<SponserState> {
  SponserNotifier(this._apiService)
      : super(SponserState(hasNext: true, sponser: [], isLoading: false));
  final ApiService _apiService;
  int page = 1;
  Future<bool> createSponser(
    Sponser sponser,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await _apiService.createSponser(sponser);
    final sponsers = await _apiService.getSponser();

    state = state.copyWith(
      sponser: sponsers,
      isLoading: false,
    );
    return result;
  }

  Future<void> getSponser() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });

    final sponser = await _apiService.getSponser();
    final newSponser = [...state.sponser, ...sponser!];
    if (sponser.length % 10 != 0 || sponser.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(
      const Duration(microseconds: 1500),
      () {
        state = state.copyWith(sponser: newSponser);
        page++;
      },
    );
    state = state.copyWith(isLoading: false);
  }
}
