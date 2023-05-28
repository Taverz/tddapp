// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../enitites/number_trivia.dart';

class NumberTrivialModel extends NumberTrivial {
  final String text;
  final int number;
  NumberTrivialModel({
    required this.text,
    required this.number,
  }):super(text: text, number: number);

  

  NumberTrivialModel copyWith({
    String? text,
    int? number,
  }) {
    return NumberTrivialModel(
      text: text ?? this.text,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'number': number,
    };
  }

  factory NumberTrivialModel.fromMap(Map<String, dynamic> map) {
    return NumberTrivialModel(
      text: map['text'] as String,
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());
  
  factory NumberTrivialModel.fromJsonMap(Map<String, dynamic> json){
    return NumberTrivialModel(text: json['text'], number: (json['number'] as num).toInt() );
  }

  factory NumberTrivialModel.fromJson(String source) => NumberTrivialModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NumberTrivialModel(text: $text, number: $number)';

  @override
  bool operator ==(covariant NumberTrivialModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.text == text &&
      other.number == number;
  }

  @override
  int get hashCode => text.hashCode ^ number.hashCode;
}
