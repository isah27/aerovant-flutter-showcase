import 'package:flutter/widgets.dart';

import '../theme/app_typography.dart';

enum AppTextVariant {
  display,
  headline,
  title,
  body,
  label,
  caption,
  telemetry,
  stat,
  wordmark,
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    this.variant = AppTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    super.key,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  TextStyle get _style => switch (variant) {
    AppTextVariant.display => AppTypography.display,
    AppTextVariant.headline => AppTypography.headline,
    AppTextVariant.title => AppTypography.title,
    AppTextVariant.body => AppTypography.body,
    AppTextVariant.label => AppTypography.label,
    AppTextVariant.caption => AppTypography.caption,
    AppTextVariant.telemetry => AppTypography.telemetry,
    AppTextVariant.stat => AppTypography.stat,
    AppTextVariant.wordmark => AppTypography.wordmark,
  };

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: color == null ? _style : _style.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
    );
  }
}
