import 'package:fluttertoast/fluttertoast.dart';


void showToast(var string) {
  Fluttertoast.showToast(msg: '点击了$string');
}