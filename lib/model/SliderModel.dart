import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final double value;
  final int endTime;
  final bool isSeeking;

  SliderModel(this.value, this.endTime, {this.isSeeking = false});

  @override
  List<Object> get props => [value, endTime, isSeeking];
}
