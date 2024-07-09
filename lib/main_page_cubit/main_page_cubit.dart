import '/default_export.dart';

class ExploreCubit extends Cubit<int> {
  ExploreCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}