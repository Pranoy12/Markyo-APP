import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_markyo_app/constants/error_handling.dart';
import 'package:login_markyo_app/constants/utils.dart';
import 'package:login_markyo_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:login_markyo_app/pages/first_home.dart';
import 'package:login_markyo_app/pages/home_page.dart';
import 'package:login_markyo_app/pages/home_screen.dart';
import 'package:login_markyo_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(name: name, email: email, password: password, cart: []);

      http.Response res = await http.post(
          Uri.parse('http://172.20.10.4:3000/api/signup'),
          body: jsonEncode(user.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'Account has been created! Login with same credentials.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //signIN

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('http://172.20.10.4:3000/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, HomeScreen.routeName, (route) => false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return MyHome();
            }),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
          Uri.parse('http://172.20.10.4:3000/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-Token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get user data
        http.Response userRes = await http.get(
            Uri.parse('http://172.20.10.4:3000/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-Token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
      // http.Response res = await http.post(
      //     Uri.parse('http://10.44.1.227:3000/api/signin'),
      //     body: jsonEncode({'email': email, 'password': password}),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8'
      //     });
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //     await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
      //     // Navigator.pushNamedAndRemoveUntil(
      //     //     context, HomeScreen.routeName, (route) => false);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (BuildContext context) {
      //         return HomeScreen();
      //       }),
      //     );
      //   },
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //cart
  void cartPush({
    required BuildContext context,
    required String prodname,
    required String cost,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('http://172.20.10.4:3000/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-Token': userProvider.user.token,
          });
    } catch (e) {}
  }

  //logout
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return MyHomePage();
        }),
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
