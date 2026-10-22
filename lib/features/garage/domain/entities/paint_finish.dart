import 'dart:ui';

import '../../../../core/theme/app_colors.dart';

enum PaintFinish {
  plasmaWhite('plasma_white', 'Plasma White', AppColors.plasmaWhite),
  ionBlue('ion_blue', 'Ion Blue', AppColors.ionBlue),
  voidBlack('void_black', 'Void Black', Color(0xFF2A2D34)),
  afterburnAmber(
    'afterburn_amber',
    'Afterburn Amber',
    AppColors.afterburnAmber,
  );

  const PaintFinish(this.id, this.label, this.swatch);

  final String id;
  final String label;
  final Color swatch;
}
