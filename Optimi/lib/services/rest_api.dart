import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:optimi/models/user_model.dart';
import '../../widgets/easy_toast.dart';
import 'package:http/io_client.dart';
import '../../widgets/loading_controller.dart';
import '../models/database.dart';
import '../helpers/constants.dart';

class RestApi extends GetxController {

  HttpClient httpClientIO = HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
  RxBool networkStatus = false.obs;


  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };
  var statusMessage;
  int statusCode = 0;
  var registrationAttempt = "".obs;
  var loginAttempt = "".obs;
  var serverMessage = "".obs;
  var showSuccessfulBottomSheet = "".obs;
  var resetAttempt = "".obs;

  Future<RxBool> checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        networkStatus = true.obs;
        return networkStatus;
      }
    } on SocketException catch (_) {
      ToastWidget().showToast("Please check your network", "long");
    }
    return networkStatus;
  }

  getUserDetails(String _username ) async {
    var _uri = Uri.parse(optimiUrl+"/users/$_username/enrolment");
    final response = await http.get(_uri);
    print("server resp body is ${response.body}");
    if(response.statusCode == 200) {
      final _apiResponse = json.decode(response.body.toString());
    } else {
      loginAttempt = "noResult".obs;
      final serverResponse = response.body;
      serverMessage = serverResponse.toString().obs;
    }
  }

  signIn(String _username, String _password, String _hashInfo) async {
    var _uri = Uri.parse(optimiUrl+"/login");
     if(_hashInfo=="1") {
       try {
         final queryParameters = {
           "username": _username,
           "password": _password,
           "noHash": _hashInfo
         };

         final response = await http.post(_uri, body: queryParameters);
         if(response.statusCode == 200) {
             loginAttempt = "done".obs;
         } else {
           loginAttempt = "noResult".obs;
           final serverResponse = json.decode(response.body);
           final optimiServerMsg = serverResponse["info"];
           serverMessage = optimiServerMsg.toString().obs;
         }
       } catch(e) {
         if (kDebugMode) {
           print(e);
         }
       }
     } else {
       try {
         final queryParameters = {
           "username": _username,
           "password": _password,
           "noHash": _hashInfo
         };

         final response = await http.post(_uri, body: queryParameters);
         if(response.statusCode == 200) {
           final _apiResponse = json.decode(response.body.toString());
             loginAttempt = "done".obs;

             await OptimiDatabase().createUserRecord(_apiResponse['user']['username'].toString(),
                 _apiResponse['hash'].toString(),
                 _apiResponse['user']['firstname'].toString(),
                 _apiResponse['user']['surname'].toString(),
                 _apiResponse['user']['user_id'].toString());
         } else {
           loginAttempt = "noResult".obs;
           final serverResponse = json.decode(response.body);
           final optimiServerMsg = serverResponse["info"];
           serverMessage = optimiServerMsg.toString().obs;
         }

       } catch(e) {
         if (kDebugMode) {
           print(e);
         }
       }
     }
  }
}