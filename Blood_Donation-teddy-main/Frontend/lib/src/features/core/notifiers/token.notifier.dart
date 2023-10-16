import 'package:flutter_application_1/src/api/api_services.dart';
import 'package:flutter_application_1/src/features/core/models/accesToken_model.dart';
import 'package:flutter_application_1/src/features/core/states/token.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenValueNotifier extends StateNotifier<TokenValueState> {
  TokenValueNotifier(this._apiService)
      : super(TokenValueState(hasNext: true, tokenValue: [], isLoading: false));
  final ApiService _apiService;
  int page = 1;

  Future<void> getTokenValue() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });

    final tokenValue = await _apiService.getTokenValue();
    final newTokenValue = [...state.tokenValue, ...tokenValue!];
    if (tokenValue.length % 10 != 0 || tokenValue.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(
      const Duration(microseconds: 1500),
      () {
        state = state.copyWith(tokenValue: newTokenValue);
        page++;
      },
    );
    state = state.copyWith(isLoading: false);
  }

  Future<bool> createSponserToken(AccessToken accessToken) async {
    final approvedUser = await _apiService.createSponserToken(accessToken);
    if (approvedUser) {
      final donatingUsers = await _apiService.getTokenValue();
      state.tokenValue = donatingUsers!;
      return true;
    }
    return false;
  }
}
