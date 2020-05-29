import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/mockito.dart';
import 'package:poke_app/core/mobx/store_state.dart';

class MockObservableFuture extends Mock implements mobx.ObservableFuture {}

void main() {
  MockObservableFuture observableFuture;
  setUp(() {
    observableFuture = MockObservableFuture();
  });

  group('StoreStateMapper', () {
    test(
      'should return StoreState.Initial when the future is null',
      () async {
        //arrange
        mobx.ObservableFuture _observableFuture;

        //act
        var result =
            StoreStateMapper.mapFutureStateToStoreState(_observableFuture);

        //assert
        expect(result, StoreState.Initial);
      },
    );

    test(
      'should return StoreState.Initial when the future status is rejected',
      () async {
        //arrange
        when(observableFuture.status).thenReturn(mobx.FutureStatus.rejected);

        //act
        var result =
            StoreStateMapper.mapFutureStateToStoreState(observableFuture);

        //assert
        expect(result, StoreState.Initial);
      },
    );

    test(
      'should return StoreState.Loading when the future status is pending',
      () async {
        //arrange
        when(observableFuture.status).thenReturn(mobx.FutureStatus.pending);

        //act
        var result =
            StoreStateMapper.mapFutureStateToStoreState(observableFuture);

        //assert
        expect(result, StoreState.Loading);
      },
    );

    test(
      'should return StoreState.Loaded when the future status is fulfilled',
      () async {
        //arrange
        when(observableFuture.status).thenReturn(mobx.FutureStatus.fulfilled);

        //act
        var result =
            StoreStateMapper.mapFutureStateToStoreState(observableFuture);

        //assert
        expect(result, StoreState.Loaded);
      },
    );
  });
}
