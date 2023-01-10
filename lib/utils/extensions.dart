import 'package:flutter/cupertino.dart';

extension ExtendedInt on int {
  height() {
    return SizedBox(height: toDouble());
  }

  width() {
    return SizedBox(width: toDouble());
  }
}
