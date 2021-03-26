import 'package:rick_morty_paginate/datasources/api/ApiService.dart';
import 'package:rick_morty_paginate/datasources/api/resource/Resource.dart';
import 'package:rick_morty_paginate/models/CharacterPageRepo.dart';
import 'package:rick_morty_paginate/models/CharacterRepo.dart';
import 'package:rxdart/subjects.dart';

class HomeBloc {
  final service = ApiService();
  final List<CharacterRepo> _characters = [];

  int page = 1;
  bool loadMore = true;
  bool isLoading = false;

  final _characterController = PublishSubject<Resource<List<CharacterRepo>>>();

  Stream<Resource<List<CharacterRepo>>> get characters =>
      _characterController.stream;

  clearProducts() {
    page = 1;
    _characters.clear();
    loadMore = true;
  }

  doRequest(bool refresh) async {
    if (refresh) clearProducts();

    if (loadMore && !isLoading) {
      isLoading = true;
      final Resource<CharacterPageRepo> dto =
          await service.getCharacterPage(page);
      loadMore = false;
      if (dto is Success<CharacterPageRepo>) {
        _characters.addAll(dto.value.results);
        final _response = Resource<List<CharacterRepo>>.success(_characters);
        _characterController.sink.add(_response);
        if (dto.value.results.length != 0) {
          page += 1;
          loadMore = true;
        } else {
          loadMore = false;
        }
      }
      isLoading = false;
    }
  }

  void dispose() {
    _characterController.close();
  }
}
