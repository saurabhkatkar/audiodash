import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final double value;
  final int endTime;

  SliderModel(this.value, this.endTime);

  @override
  List<Object> get props => [value, endTime];
}
