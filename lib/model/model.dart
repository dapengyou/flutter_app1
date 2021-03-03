import 'package:json_annotation/json_annotation.dart';
part 'model.g.dart';

@JsonSerializable()
class  Mate {
  var name;
  var age;
  Mate(this.name,this.age);
  factory Mate.fromJson(Map<String,dynamic> json) => _$MateFromJson(json);
  Map<String,dynamic> toJson() => _$MateToJson(this);
}
