
import 'package:explore_uganda/default_export.dart';

class ImageCubit extends Cubit<int> {
  ImageCubit() : super(0);
  
  

  void changeImage() {

    emit(state + 1);
  }

  void decrement() => emit(state - 1);
}
