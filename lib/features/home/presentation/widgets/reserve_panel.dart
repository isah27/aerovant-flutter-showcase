import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/glass_panel.dart';
import '../../../reservation/presentation/widgets/reservation_sheet.dart';

class ReservePanel extends StatelessWidget {
  const ReservePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const AppText(AppStrings.reserveTitle, variant: AppTextVariant.title),
          const SizedBox(height: AppSpacing.xxs),
          const AppText(AppStrings.reserveBody),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: AppStrings.reserveCta,
            onPressed: () => ReservationSheet.show(context),
          ),
        ],
      ),
    );
  }
}
