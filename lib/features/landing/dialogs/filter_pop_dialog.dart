import 'package:flutter/material.dart';
import 'package:my_trainings_app/features/landing/providers/dialog_sel_providers.dart';
import 'package:my_trainings_app/features/landing/widgets/filter_widgets.dart';

void showFilterPopDialog({
  required BuildContext context,
  required FilterLocationSelProvider locationSelProvider,
  required FilterTrainerSelProvider trainerSelProvider,
  required FilterTrainingNamesSelProvider namesSelProvider,
}) =>
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        builder: (ctx) => FilterDialogWidget(
              locationSelProvider: locationSelProvider,
              trainerSelProvider: trainerSelProvider,
              namesSelProvider: namesSelProvider,
            ));
