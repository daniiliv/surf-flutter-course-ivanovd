import 'dart:convert';

import 'package:places/API/dio_api.dart';
import 'package:places/data/dto/place_dto.dart';
import 'package:places/data/repository/place_mapper.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/places_filter_request.dart';

/// Получает данные мест по сети.
class NetworkPlaceRepository implements PlaceRepository {
  // Клиент для работы с АПИ.
  final DioApi _apiUtil;

  NetworkPlaceRepository(
    this._apiUtil,
  );

  /// Добавляет новое место в список мест.
  ///
  /// Возвращает добавленное место.
  @override
  Future<Place> addNewPlace(Place place) async {
    final placeDto = PlaceMapper.placeToDto(place);
    final body = jsonEncode(placeDto.toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/place', data: body);

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final newPlaceDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return PlaceMapper.placeFromDto(newPlaceDto);
  }

  /// Получает место по id.
  @override
  Future<Place> getPlaceById(String id) async {
    final response = await _apiUtil.httpClient.get<String>(
      '/place/$id',
    );

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final placeDto = PlaceDTO.fromJson(
      jsonDecode(response.data as String) as Map<String, dynamic>,
    );

    return PlaceMapper.placeFromDto(placeDto);
  }

  /// Получает список всех мест.
  @override
  Future<List<Place>> getPlaces() async {
    final response = await _apiUtil.httpClient.get<String>('/place');

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final rawPlacesJson = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeList = rawPlacesJson
        .map((rawPlaceJson) =>
            PlaceMapper.placeFromDto(PlaceDTO.fromJson(rawPlaceJson)))
        .toList();

    return placeList;
  }

  /// Получает отфильтрованный список мест.
  @override
  Future<List<Place>> getFilteredPlaces(
    PlacesFilterRequest placesFilterRequest,
  ) async {
    final placesFilterRequestDto = placesFilterRequest.toDto();
    final body = jsonEncode(placesFilterRequestDto.toJson());
    final response =
        await _apiUtil.httpClient.post<String>('/filtered_places', data: body);

    // TODO(daniiliv): Тех.долг - нужна обработка ошибок.
    final rawPlacesJson = (jsonDecode(response.data as String) as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final placeList = rawPlacesJson
        .map((rawPlaceJson) =>
            PlaceMapper.placeFromDto(PlaceDTO.fromJson(rawPlaceJson)))
        .toList();

    return placeList;
  }
}
