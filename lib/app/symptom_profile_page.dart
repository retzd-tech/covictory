import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SymptomProfilePage extends StatefulWidget {
  @override
  _SymptomProfilePageState createState() => _SymptomProfilePageState();
}

class _SymptomProfilePageState extends State<SymptomProfilePage> {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<bool> isSoreThroat = [false, false];
  List<bool> isFatigue = [false, false];

  @override
  void initState() {
    super.initState();
    getSymptom();
  }

  getSymptom() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    try {
      await firestore
          .collection("symptoms")
          .document(uid)
          .get(source: Source.server)
          .then((value) {
        setState(() {
          isSoreThroat = value.data['isSoreThroat'].cast<bool>();
          isFatigue = value.data['isFatigue'].cast<bool>();
        });
      });
    } catch (_) {}
  }

  setSymptom() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    await firestore
        .collection("symptoms")
        .document(uid)
        .setData({"isSoreThroat": isSoreThroat, "isFatigue": isFatigue});

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 900.w,
              child: Text(
                'Apakah anda merasa tidak nyaman dan nyeri tenggorokan?',
                softWrap: true,
                style: TextStyle(fontSize: 60.sp),
              ),
            ),
            ToggleButtons(
              children: <Widget>[
                Text(
                  'Ya',
                  style: TextStyle(fontSize: 40.sp),
                ),
                Text(
                  'Tidak',
                  style: TextStyle(fontSize: 40.sp),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSoreThroat.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSoreThroat[buttonIndex] = true;
                    } else {
                      isSoreThroat[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSoreThroat,
            ),
            SizedBox(
              height: 40.w,
            ),
            Container(
              width: 900.w,
              child: Text(
                'Apakah anda merasa kelelahan?',
                softWrap: true,
                style: TextStyle(fontSize: 60.sp),
              ),
            ),
            ToggleButtons(
              children: <Widget>[
                Text(
                  'Ya',
                  style: TextStyle(fontSize: 40.sp),
                ),
                Text(
                  'Tidak',
                  style: TextStyle(fontSize: 40.sp),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isFatigue.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isFatigue[buttonIndex] = true;
                    } else {
                      isFatigue[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isFatigue,
            ),
            SizedBox(
              height: 40.w,
            ),
            RaisedButton(
              textColor: Colors.white,
              onPressed: setSymptom,
              child: Text('Simpan'),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
