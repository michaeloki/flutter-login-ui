import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:optimi/models/database.dart';
import '../services/rest_api.dart';
import '../widgets/common_scheme.dart';

bool loadingStatus = true;
late String platformVersionDetails, deviceOS, adMobId, codeScannerAppId;
late String codeScannerAdUnitId, deviceUuid = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: colorCustom,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeDashboard(username: '', firstname: '', surname: ''),
        builder: EasyLoading.init());
  }
}

class HomeDashboard extends StatefulWidget {


  const HomeDashboard({Key? key, required this.username, required this.firstname, required this.surname}) : super(key: key);
  final String username;
  final firstname;
  final surname;

  @override
  HomeDashboardState createState() => HomeDashboardState();
}

class HomeDashboardState extends State<HomeDashboard>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final RestApi restApi = Get.put(RestApi());
  String userId = "";
  String firstName = "";
  String surname = "";

  fetchRemoteUserInfo() {
    restApi.getUserDetails(widget.username);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    fetchRemoteUserInfo();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print("didChangeAppLifecycle===home $state");
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: const Color(0xFF11274A),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.home,
                color: Colors.white,
              ),
              Flexible(
                child: Text("Dashboard",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              )
            ],
          ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.exit_to_app_outlined,
                color: Colors.white,
              ),
              tooltip: 'Logout',
              onPressed: () {
                exit(0);
                //Navigator.pushNamed(context, '/loginScreen');
              },
            ),
          ]),
      body: WillPopScope(
        onWillPop: () async {
          Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.
          return false;
        },
        child:  Center (
          child: Column(
            children:  [
              Text(userId),
              Text("Welcome " + widget.firstname + " " + widget.surname,
                  style: const TextStyle(color: Colors.black, fontSize: 23)),
            ],
          ),
        ),
      ),
    );
  }
}
