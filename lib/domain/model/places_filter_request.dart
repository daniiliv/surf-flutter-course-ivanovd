import 'package:places/data/dto/places_filter_request_dto.dart';
import 'package:places/domain/model/coordinate_point.dart';
import 'package:places/domain/model/place.dart';

/// Модель параметров фильтра.
///
/// Все поля не обязательные, но параметры "coordinatePoint" и "radius" зависят друг от друга,
/// поэтому если указан один из них, то второй становятся обязательным.
class PlacesFilterRequest {
  /// Координаты
  final CoordinatePoint? coordinatePoint;

  /// Радиус поиска места
  final double? radius;

  /// Список типов мест
  final List<PlaceTypes>? typeFilter;

  /// Имя места
  final String? nameFilter;

  const PlacesFilterRequest({
    this.coordinatePoint,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  });

  PlacesFilterRequestDto toDto() {
    double? lat;
    double? lon;
    double? radius;
    List<String>? typeFilter;

    // Если параметры координат и радиуса поиска заполнены, то добавим их в модель данных фильтра мест.
    if (coordinatePoint != null && this.radius != null && this.radius != 0) {
      lat = coordinatePoint!.lat;
      lon = coordinatePoint!.lon;
      radius = this.radius;
    }

    if (this.typeFilter != null && this.typeFilter!.isNotEmpty) {
      typeFilter = this
          .typeFilter!
          .map((typeFilterItem) => typeFilterItem.name)
          .toList();
    }

    final placesFilterRequestDto = PlacesFilterRequestDto(
      lat: lat,
      lng: lon,
      radius: radius,
      typeFilter: typeFilter,
      nameFilter: nameFilter,
    );

    return placesFilterRequestDto;
  }
}
