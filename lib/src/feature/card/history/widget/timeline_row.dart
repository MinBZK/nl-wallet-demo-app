import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/model/timeline_attribute.dart';
import '../../../../util/formatter/time_ago_formatter.dart';
import '../../../../util/formatter/timeline_attribute_title_formatter.dart';
import '../../../../util/mapper/timeline_attribute_type_color_mapper.dart';
import '../../../../util/mapper/timeline_attribute_type_icon_color_mapper.dart';
import '../../../../util/mapper/timeline_attribute_type_icon_mapper.dart';
import '../../../../util/mapper/timeline_attribute_type_text_mapper.dart';
import '../../../verification/widget/status_icon.dart';

class TimelineRow extends StatelessWidget {
  final TimelineAttribute attribute;

  const TimelineRow({required this.attribute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final Color iconColor = TimelineAttributeTypeIconColorMapper.map(theme, attribute);
    final IconData iconData = TimelineAttributeTypeIconMapper.map(attribute);
    final String titleText = TimelineAttributeTitleFormatter.format(attribute);
    final String typeText = TimelineAttributeTypeTextMapper.map(locale, attribute);
    final Color typeTextColor = TimelineAttributeTypeColorMapper.map(theme, attribute);
    final String timeAgoText = TimeAgoFormatter.format(locale, attribute.dateTime);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: StatusIcon(color: iconColor, icon: iconData),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: titleText.isNotEmpty,
                      child: Text(titleText, style: Theme.of(context).textTheme.subtitle1),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      typeText,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: typeTextColor),
                    ),
                    const SizedBox(height: 2),
                    Text(timeAgoText, style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
