import 'package:json_annotation/json_annotation.dart';

part 'loginModel.g.dart';

@JsonSerializable(nullable: false)
class LoginData {
  bool admin;
  List<dynamic> chapterTops;
  List<dynamic> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  LoginData(
      {this.admin,
      this.chapterTops,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
