import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quality_item_state.dart';

class QualityItemCubit extends Cubit<QualityItemState> {
  QualityItemCubit() : super(QualityItemLoaded(name: "System iOS", index: 1));

  void changeQualityItemIndex(int index) {
    QualityItemLoaded state = this.state as QualityItemLoaded;

    if (index >= 0 && index <= 2) {
      emit(QualityItemLoaded(index: index, name: state.name));
    } else {
      // emit(QualityItemLoaded(index: index, name: state.name));
    }
  }

  void changeQualityItemName(String name) {
    QualityItemLoaded state = this.state as QualityItemLoaded;
    emit(QualityItemLoaded(index: state.index, name: name));
  }
}
