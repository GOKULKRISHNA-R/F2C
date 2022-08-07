import 'package:customize/customize.dart';
import 'package:f2c/screens/home/addYeild.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../authenticate/authenticate.dart';

class Farmer extends StatefulWidget {
  const Farmer({Key? key}) : super(key: key);

  @override
  _FarmerState createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          backgroundColor: FxColors.green600,
          elevation: 0.0,
          title: const Text(
            'Farmer',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[

            TextButton.icon(

              onPressed: () async {
                await _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Authenticate()),
                );
              },

              icon: const Icon(
                Icons.person,
                color: Colors.black87,
              ),

              label: const Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),]
      ),

      body: Padding(
        padding: const EdgeInsets.all(135.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: FxColors.green600,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddYeild()),
              );
            } ,
            child: Text('Add My Product')
        ),
      ),
    );
  }
}
