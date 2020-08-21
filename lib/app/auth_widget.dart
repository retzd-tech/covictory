import 'package:covictory_ar/app/home_page.dart';
import 'package:covictory_ar/app/sign_in/sign_in_page.dart';
import 'package:covictory_ar/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPageBuilder();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
