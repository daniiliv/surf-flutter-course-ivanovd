import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';
import 'package:places/ui/screen/components/default_button.dart';
import 'package:places/ui/screen/components/padded_divider.dart';

/// Виджет для отображения подробностей достопримечательности.
///
/// Отображает картинку, название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 360,
            child: _SightDetailsTop(),
          ),
          Expanded(
            flex: 400,
            child: _SightDetailsBottom(
              sight: sight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет для отображения верхней части подробностей достопримечательности.
///
/// Отображает картинку места и имеет кнопку "Назад".
class _SightDetailsTop extends StatelessWidget {
  const _SightDetailsTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Здесь будет картинка места.
        Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.lightBlueShade800,
        ),
        const Positioned(
          left: 16,
          top: 36,
          child: _BackButton(),
        ),
      ],
    );
  }
}

/// Виджет для отображения нижней части подробностей достопримечательности.
///
/// Отображает название, тип, режим работы, описание места.
/// Предоставляет возможность построить маршрут к этому месту.
/// Также есть возможность запланировать поход в место и добавить его в список избранного.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class _SightDetailsBottom extends StatelessWidget {
  final Sight sight;

  const _SightDetailsBottom({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: Column(
        children: [
          _SightInfo(sight: sight),
          Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 16.0,
              right: 16.0,
            ),
            child: DefaultButton(
              text: AppStrings.buildRouteText,
              textStyle: AppTypography.roboto14Regular.copyWith(
                color: AppColors.white,
              ),
              color: AppColors.fruitSalad,
              height: 48,
              // Картинка кнопки - пока что это просто белый контейнер.
              buttonLabel: Container(
                width: 20,
                height: 22,
                color: AppColors.white,
              ),
            ),
          ),
          const PaddedDivider(
            top: 24,
            left: 16,
            right: 16,
            bottom: 19,
            thickness: 0.8,
          ),
          const _SightActionsButtons(),
        ],
      ),
    );
  }
}

/// Виджет для отображения информации о достопримечательности.
///
/// Отображает название, тип, режим работы, описание места.
///
/// Обязательный параметр конструктора: [sight] - модель достопримечательности.
class _SightInfo extends StatelessWidget {
  final Sight sight;

  const _SightInfo({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 16.0,
            ),
            child: Text(
              sight.name,
              style: AppTypography.roboto24Regular
                  .copyWith(color: AppColors.oxfordBlue),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 16.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  sight.type.toString(),
                  style: AppTypography.roboto14Regular
                      .copyWith(color: AppColors.oxfordBlue),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 16.0,
              ),
              child: Text(
                '${AppStrings.closedTo} ${sight.workTimeFrom}',
                style: AppTypography.roboto14Regular.copyWith(
                  color: AppColors.waterloo,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Text(
            sight.details,
            style: AppTypography.roboto14Regular.copyWith(
              color: AppColors.oxfordBlue,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

/// Виджет для отображения кнопок для работы с достопримечательностью.
///
/// Предоставляет возможность запланировать поход в место и добавить его в список избранного.
class _SightActionsButtons extends StatelessWidget {
  const _SightActionsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: ToPlanButton(),
        ),
        Expanded(
          child: _ToFavouritesButton(),
        ),
      ],
    );
  }
}

/// Кнопка "Запланировать" поход в указанное место.
class ToPlanButton extends StatelessWidget {
  const ToPlanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 22,
          height: 19,
          color: AppColors.waterlooInactive,
        ),
        const SizedBox(
          width: 9,
        ),
        Text(
          AppStrings.planText,
          style: AppTypography.roboto14Regular.copyWith(
            color: AppColors.waterlooInactive,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Кнопка "Добавить в избранное" указанное место.
class _ToFavouritesButton extends StatelessWidget {
  const _ToFavouritesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 18,
          color: AppColors.oxfordBlue,
        ),
        const SizedBox(
          width: 9,
        ),
        Text(
          AppStrings.toFavourites,
          style: AppTypography.roboto14Regular.copyWith(
            color: AppColors.oxfordBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

/// Кнопка "Вернуться назад" в список.
class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
      ),
      width: 32,
      height: 32,
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 15.0,
        color: AppColors.martinique,
      ),
    );
  }
}