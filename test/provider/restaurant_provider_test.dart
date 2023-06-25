import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_new/data/api/api_service.dart';
import 'package:restaurant_app_new/data/model/restaurant_list.dart';
import 'package:restaurant_app_new/provider/restaurant_list_provider.dart';
import 'package:restaurant_app_new/utils/result_state.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('RestaurantProvider Test', () {
    late MockApiService apiService;
    late RestaurantProvider restaurantProvider;

    setUp(() {
      apiService = MockApiService();
      when(apiService.restauranList()).thenAnswer(
        (_) async => RestaurantResponse(
          error: false,
          message: '',
          count: 0,
          restaurants: [],
        ),
      );
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });

    test(
        'Fetch restaurants updates state to noData when no restaurants are present',
        () async {
      await restaurantProvider.fetchRestaurantListAll();
      expect(restaurantProvider.state, ResultState.noData);
    });
  });
}
