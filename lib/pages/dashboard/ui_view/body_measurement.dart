import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covictory_ar/model/symptom.dart';
import 'package:covictory_ar/pages/dashboard/fintness_app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BodyMeasurementView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  BodyMeasurementView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _BodyMeasurementViewState createState() => _BodyMeasurementViewState();
}

class _BodyMeasurementViewState extends State<BodyMeasurementView> {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
          symptomList = listSymptomFromJson(value.data);
        });
      });
    } catch (e) {}
  }

  Future<void> setSymptom() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    await firestore
        .collection("symptoms")
        .document(uid)
        .setData(listSymptomToJson(symptomList));
  }

  @override
  dispose() {
    setSymptom();
    super.dispose();
  }

  Widget symptomItem({String question, List<bool> answers}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  question,
                  style: TextStyle(
                    fontFamily: FintnessAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.2,
                    color: FintnessAppTheme.darkText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: ToggleButtons(
                    constraints: BoxConstraints.tightFor(height: 30, width: 50),
                    borderColor: Colors.transparent,
                    children: <Widget>[
                      Text(
                        'Ya',
                        style: TextStyle(
                          fontFamily: FintnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: FintnessAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        'Tidak',
                        style: TextStyle(
                          fontFamily: FintnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: FintnessAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < answers.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            answers[buttonIndex] = true;
                          } else {
                            answers[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: answers,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 18, bottom: 16),
                decoration: BoxDecoration(
                  color: FintnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FintnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: symptomList
                      .map((e) =>
                          symptomItem(question: e.text, answers: e.answer))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
