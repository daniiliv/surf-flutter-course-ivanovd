import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/UI/screens/components/place_card/base_place_card.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/helpers/app_assets.dart';

/// Виджет карточки места. Наследуется от [BasePlaceCard].
///
/// Переопределяет поле [actions] - в списке кнопок карточки 1 элемент - кнопка добавления в избранное/удаления из избранного.
/// Также переопределяет поле [showDetails] - для отображения детальной информации о месте.
///
/// Отображает краткую информацию о месте.
///
/// Параметры:
/// * [place] - модель места (обязательный);
/// * [toggleFavorites] - коллбэк нажатия на добавление в избранное / удаление из избранного;
class PlaceCard extends BasePlaceCard {
  final VoidCallback toggleFavorites;

  @override
  final Widget actions;

  @override
  bool get showDetails => true;

  PlaceCard(
    Place place, {
    Key? key,
    required this.toggleFavorites,
  })  : actions = _PlaceActions(
          isFavorite: place.isFavorite,
          toggleFavorites: toggleFavorites,
        ),
        super(
          place,
          key: key,
        );
}

/// Список кнопок для работы с карточкой.
class _PlaceActions extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback toggleFavorites;

  const _PlaceActions({
    Key? key,
    required this.isFavorite,
    required this.toggleFavorites,
  }) : super(key: key);

  @override
  State<_PlaceActions> createState() => _PlaceActionsState();
}

/// Состояние кнопок.
///
/// Хранит в себе СтримКонтроллер для переключения кнопки "В избранное"/"Убрать из избранного".
class _PlaceActionsState extends State<_PlaceActions> {
  final StreamController<bool> _actionStreamController = StreamController();

  @override
  void initState() {
    super.initState();
    _actionStreamController.add(widget.isFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    _actionStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
      ),
      child: StreamBuilder<bool>(
        stream: _actionStreamController.stream,
        builder: (context, snapshot) {
          final isFavorite = snapshot.data ?? false;

          // Переключение кнопок "В избранное"/"Убрать из избранного"
          return InkWell(
            child: SvgPicture.asset(
              isFavorite ? AppAssets.heartFilled : AppAssets.heart,
            ),
            onTap: () => _toggleFavorites(isFavorite),
          );
        },
      ),
    );
  }

  /// Переключение кнопки "Добавить в избранное" / "Убрать из избранного"
  void _toggleFavorites(bool isFavorite) {
    widget.toggleFavorites();
    _actionStreamController.add(!isFavorite);
  }
}
