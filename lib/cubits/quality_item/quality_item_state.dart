part of 'quality_item_cubit.dart';

@immutable
abstract class QualityItemState {}

class QualityItemLoaded extends QualityItemState {
  final int index;
  final String name;

  QualityItemLoaded({
    required this.index,
    required this.name,
  });
}
