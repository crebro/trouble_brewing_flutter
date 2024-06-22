import 'package:flutter/material.dart';

enum Additive { BISCUIT, CREAM, BAR, SUGAR, COOKIE }

mixin AdditiveConstants {
  static const Map<Additive, IconData> addtiveIcons = {
    Additive.BISCUIT: Icons.airlines_rounded,
    Additive.CREAM: Icons.icecream,
    Additive.BAR: Icons.edit,
    Additive.SUGAR: Icons.check_box_outline_blank,
    Additive.COOKIE: Icons.cookie,
  };
}
