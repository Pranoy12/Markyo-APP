import 'package:flutter/material.dart';
import 'package:login_markyo_app/pages/home_screen.dart';
import 'package:login_markyo_app/pages/login_page.dart';
import 'package:login_markyo_app/pages/splash.dart';
import 'package:login_markyo_app/providers/user_provider.dart';
import 'package:login_markyo_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ],
    child: const Markyo(),
  ));
}

class Markyo extends StatefulWidget {
  const Markyo({super.key});

  @override
  State<Markyo> createState() => _MarkyoState();
}

class _MarkyoState extends State<Markyo> {
  final AuthService authService = AuthService();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      debugShowCheckedModeBanner: false,
      // home: Provider.of<UserProvider>(context).user.token?.isNotEmpty ?? true
      //     ? const LoginPage()
      //     : const MyRegister(),
      routes: {
        '/': (context) =>
            Provider.of<UserProvider>(context).user.token?.isNotEmpty ?? true
                ? const splash()
                : const LoginPage(), //const LoginPage(),
        '/homescreen': (context) => const HomeScreen(),
        // '/': (context) => MyRegister(),
      },
    );
  }
}

// class Markyo extends StatelessWidget {
//   const Markyo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: {
//         '/': (context) => const LoginPage(),
//         '/homescreen': (context) => const HomeScreen(),
//         // '/': (context) => MyRegister(),
//       },
//     );
//   }
// }
