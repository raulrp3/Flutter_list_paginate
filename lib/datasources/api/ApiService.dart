import 'package:http/http.dart';
import 'package:rick_morty_paginate/datasources/api/resource/Resource.dart';
import 'package:rick_morty_paginate/datasources/api/resource/ResourceHandler.dart';
import 'package:rick_morty_paginate/models/CharacterPageRepo.dart';

class ApiService {
  final Client _client = Client();

  Future<Resource<CharacterPageRepo>> getCharacterPage(int page) async {
    final response = _client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'));

    return resourceBuilder<CharacterPageRepo, CharacterPageRepo>(
        response, CharacterPageRepo.fromJson);
  }
}
