import 'package:flutter/material.dart';
import 'package:login_markyo_app/providers/user_provider.dart';
import 'package:login_markyo_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          "PROFILE",
          style: TextStyle(
            fontSize: 30,
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/shopbg.jpg'),
          fit: BoxFit.fill,
        )),
        child: Wrap(
          spacing: 20,
          runSpacing: 415,
          alignment: WrapAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.person_outlined),
              color: Colors.black,
              iconSize: 150,
              onPressed: () {},
            ),
            Text(
              user.name,
              style: TextStyle(fontSize: 20, color: Colors.black, height: 5),
            ),
            ElevatedButton(
              child: Text(
                "REWARDS",
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
            ElevatedButton(
              child: Text(
                "LOGOUT",
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
              onPressed: () {
                AuthService().logOut(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
