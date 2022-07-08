import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class SelectedItemCubit extends Cubit<int> {
  SelectedItemCubit() : super(1);
  void changeSelectedItem(int index) {
    if (index >= 0 && index <= 2) {
      emit(index);
    } else {
      emit(1);
    }
  }
}
