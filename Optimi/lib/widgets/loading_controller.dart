import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingController {
  generalLoader() {
    EasyLoading.show();
  }

  closeLoader() {
    EasyLoading.dismiss();
  }
}


