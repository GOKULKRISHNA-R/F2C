import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './services/auth.dart';
import './screens/wrapper.dart';
import './models/user.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      StreamProvider<UserCls?>.value(
        value: AuthService().user,
        initialData: null,
        child: const MaterialApp(
          home: Wrapper(),
        ),
      );
  }
}
