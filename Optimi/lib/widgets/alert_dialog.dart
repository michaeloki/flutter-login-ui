import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class AlertController  {
  Future<void> appAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20)),
                AvatarGlow(
                  startDelay:  const Duration(milliseconds: 500),
                  glowColor: const Color.fromRGBO(10, 52, 125, 1),
                  endRadius: 100.0,
                  duration: const Duration(milliseconds: 7000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration:
                  const Duration(milliseconds: 100),
                  child: Material(
                    elevation: 16.0,
                    color: Colors.transparent,
                    child: Image.asset('assets/icons/optimiIcon.png',height: 100,),
                  ),
                  shape: BoxShape.rectangle,
                  animate: true,
                  curve: Curves.bounceOut,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> closeAlert(BuildContext context) async {
    Navigator.pop(context);
  }
}