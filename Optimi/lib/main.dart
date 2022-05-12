import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:optimi/screens/dashboard.dart';
import 'package:optimi/services/rest_api.dart';
import 'package:optimi/widgets/alert_dialog.dart';
import 'package:optimi/widgets/common_scheme.dart';
import 'package:optimi/widgets/easy_toast.dart';
import 'package:sqflite/sqflite.dart';
import 'models/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Optimi Login',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: const MyHomePage(title: 'Optimi Login'),
      routes: {
        '/mainMenu': (context) =>
            const HomeDashboard(username: '', firstname: '', surname: ''),
        '/loginScreen': (context) => const MyHomePage(
              title: 'Optimi Login',
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  final RestApi restApi = Get.put(RestApi());
  String? fullName = "",
      emailAddress = "",
      username = "",
      mobileNumber = "",
      countryCode = "",
      password = "",
      noHash = "",
      firstname = "",
      surname = "";
  bool _obscureText = false;
  var _netResult = false.obs;

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  openDashboard() async {
    if (restApi.loginAttempt == "done".obs) {
      AlertController().closeAlert(context);
      try {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDashboard(
                username: username!, firstname: firstname!, surname: surname!),
          ),
        );
      } catch (e) {
        if (kDebugMode) {
          print(" Exception $e");
        }
      }
    }
  }

  autoLogin() async {
    List _getUserInfo = [];
    await OptimiDatabase()
        .getAllRecords()
        .then((value) => {_getUserInfo = value});

    if (_getUserInfo.isNotEmpty) {
      AlertController().appAlert(context);
      username = _getUserInfo[0]["username"];
      firstname = _getUserInfo[0]["firstname"];
      surname = _getUserInfo[0]["surname"];
      await restApi.signIn(
          _getUserInfo[0]["username"], _getUserInfo[0]["password"], "1");
      openDashboard();
    }
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _offlineMessage() {
    ToastWidget().showToast('Network Error!', "long");
  }

  _loginButton() async {
    await RestApi().checkNetwork().then((value) => _netResult = value);
    if (_netResult.isTrue) {
      if (username!.isNotEmpty && password!.isNotEmpty) {
        AlertController().appAlert(context);

        await restApi.signIn(
            username!.trim(), password!.trim(), noHash!.trim());
      }
      if (restApi.loginAttempt == "done".obs) {
        AlertController().closeAlert(context);
        try {
          print("username is $username");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDashboard(
                  username: username!,
                  firstname: firstname!,
                  surname: surname!),
            ),
          );
        } catch (e) {
          if (kDebugMode) {
            print(" Exception $e");
          }
        }
      }

      if (restApi.loginAttempt == "noResult".obs) {
        AlertController().closeAlert(context);
        ToastWidget().showToast(restApi.serverMessage.toString(), "long");
      }
    } else {
      _offlineMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var screenHeight = size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.key_outlined,
              color: Colors.white,
            ),
            Flexible(
              child: Text(" Optimi",
                  style: TextStyle(color: Colors.white, fontSize: 22)),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 16.0,
              color: Colors.white,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight * 0.4,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(16.0, screenHeight * 0.05, 16.0, 0),
                    child: Form(
                      key: _formLoginKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: 'Username',
                                            labelText: 'Username'),
                                        validator: (val) => val!.isEmpty
                                            ? 'Your username is required'
                                            : null,
                                        onChanged: ((value) => {
                                              setState(() {
                                                username = value;
                                              })
                                            }),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(children: <Widget>[
                                      Expanded(
                                          child: TextFormField(
                                        obscureText: !_obscureText,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: const InputDecoration(
                                            hintText: '********',
                                            labelText: 'Password'),
                                        validator: (val) => val!.length < 10
                                            ? 'Your password should be 10 characters long'
                                            : null,
                                        onChanged: (value) {
                                          setState(() {
                                            password = value.trim();
                                          });
                                        },
                                        obscuringCharacter: "#",
                                      )),
                                      if (_obscureText == false)
                                        IconButton(
                                            icon: const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                            onPressed: _togglePassword),
                                      if (_obscureText == true)
                                        IconButton(
                                            icon: const Icon(
                                              Icons.visibility,
                                              color: Colors.black,
                                            ),
                                            onPressed: _togglePassword),
                                    ]),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 15, right: 0, bottom: 0),
                                    child: SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          splashFactory:
                                              InkRipple.splashFactory,
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            const Color(0xFF11274A),
                                          ),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                            const Color(0xFF11274A),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                        ),
                                        child: const Text(
                                          'Login',
                                        ),
                                        onPressed: () {
                                          _loginButton();
                                        },
                                        //backgroundColor:Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
