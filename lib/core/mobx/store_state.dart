import 'package:mobx/mobx.dart';

enum StoreState { Initial, Loading, Loaded }

class StoreStateMapper {
  static StoreState mapFutureStateToStoreState(ObservableFuture future){
    if (future == null ||
        future.status == FutureStatus.rejected)
      return StoreState.Initial;
    else if (future.status == FutureStatus.pending)
      return StoreState.Loading;
    else
      return StoreState.Loaded;
  }
}