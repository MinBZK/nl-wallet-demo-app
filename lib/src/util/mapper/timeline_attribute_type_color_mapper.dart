import 'package:flutter/material.dart';

import '../../domain/model/timeline_attribute.dart';

class TimelineAttributeTypeColorMapper {
  static Color map(ThemeData themeData, TimelineAttribute attribute) {
    if (attribute is InteractionAttribute) return InteractionTypeColorMapper.map(themeData, attribute.interactionType);
    if (attribute is OperationAttribute) return themeData.colorScheme.onBackground;
    throw ('Unsupported attribute: $attribute');
  }
}

class InteractionTypeColorMapper {
  static Color map(ThemeData themeData, InteractionType type) {
    switch (type) {
      case InteractionType.failed:
        return themeData.colorScheme.error;
      default:
        return themeData.colorScheme.onBackground;
    }
  }
}
