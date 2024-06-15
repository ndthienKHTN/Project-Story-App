import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:project_login/Services/StoryService.dart';
import 'package:http/http.dart' as http;
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:mockito/mockito.dart';
class MockClient extends Mock implements http.Client {
  MockClient(this.client);

  final http.Client client;
}
class TestStoryService extends StoryService {
  final http.Client client;

  TestStoryService({required this.client});
}
void main() {
  group('StoryService Integration Test', () {
    late MockClient mockClient;
    late StoryService storyService;

    setUp(() {
      mockClient = MockClient(http.Client());
      storyService = TestStoryService(client: mockClient);
    });

    test('fetchListNameDataSource returns a list on successful response',
            () async {
          // Mock successful response with sample data
          final mockResponse = http.Response(
              '[ "Story 1", "Story 2", "Story 3" ]',
              200);
          final mockUri = Uri.parse('http://localhost:3000/api/v1/listDataSource/');
          when(mockClient.get(mockUri)).thenAnswer((_) => Future.value(mockResponse));

          // Call the method
          final result = await storyService.fetchListNameDataSource();

          // Verify response and data
          expect(result, ['Story 1', 'Story 2', 'Story 3']);
        });

    test('fetchListNameDataSource throws exception on error response',
            () async {
          // Mock error response
              final mockUri = Uri.parse('http://localhost:3000/api/v1/listDataSource/');
              when(mockClient.get(mockUri)).thenAnswer((_) => Future.value(http.Response(
              '{"error": "Internal Server Error"}', 500)));

          // Expect an exception
          expect(() => storyService.fetchListNameDataSource(),
              throwsA(isException));
        });

    testWidgets('fetchListNameDataSource should retrieve names from the API', (WidgetTester tester) async {
      final StoryService storyService = StoryService();

      final List<String> names = await storyService.fetchListNameDataSource();

      // Add assertions to verify the retrieved names or API response
      expect(names, isList);
      expect(names.length, greaterThan(0));
      // Add more assertions as needed
    });
  });
}