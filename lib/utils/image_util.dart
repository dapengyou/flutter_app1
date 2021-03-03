import 'package:flutter/cupertino.dart';

Image getImage(path, {double width, double height}) {
  return new Image.asset(
    path,
    width: width ?? 20.0,
    height: height ?? 20.0,
  );
}
