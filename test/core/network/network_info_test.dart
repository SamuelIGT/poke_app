import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfo networkInfo;
  MockDataConnectionChecker dataConnectionChecker;

  setUp(() {
    dataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfo(dataConnectionChecker);
  });

  group('is connected', () {
    test(
      'should foward the call to DataConnectionChecker.hasConnection',
      () async {
        //arrange
        var tHasConnection = Future.value(true);
        when(dataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnection);

        //act
        var result = networkInfo.isConnected;

        //assert
        verify(dataConnectionChecker.hasConnection);
        expect(result, tHasConnection);
      },
    );
  });
}
