import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';

class NumberTrivial extends Equatable {
  final String text;
  final int number;

  NumberTrivial({
    required this.text,
    required this.number,
  });

  @override
  List<Object> get props => [text, number];
}
