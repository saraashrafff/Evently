import 'package:evently/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showSuccessMessege(String messege) => Fluttertoast.showToast(
    msg: messege,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.green,
    textColor: AppTheme.white,
    fontSize: 16.0,
  );
  static void showErrorMessege([String? messege]) => Fluttertoast.showToast(
    msg: messege ?? 'Something went wrong',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.red,
    textColor: AppTheme.white,
    fontSize: 16.0,
  );
}
