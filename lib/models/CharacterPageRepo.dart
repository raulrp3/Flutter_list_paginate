import 'package:json_annotation/json_annotation.dart';
import 'package:rick_morty_paginate/models/CharacterRepo.dart';

part 'CharacterPageRepo.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacterPageRepo {
  dynamic info;
  List<CharacterRepo> results;

  CharacterPageRepo({this.info, this.results});

  static CharacterPageRepo fromJson(Map<String, dynamic> json) =>
      _$CharacterPageRepoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterPageRepoToJson(this);
}
