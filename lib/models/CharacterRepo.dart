import 'package:json_annotation/json_annotation.dart';

part 'CharacterRepo.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterRepo {
  String name;
  String image;

  CharacterRepo({this.name, this.image});

  static CharacterRepo fromJson(Map<String, dynamic> json) =>
      _$CharacterRepoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterRepoToJson(this);
}
