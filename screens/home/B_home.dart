import 'package:customize/customize.dart';
import 'package:f2c/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';
import 'bill.dart';

class Buyer extends StatefulWidget {
  const Buyer({Key? key}) : super(key: key);

  @override
  _BuyerState createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> {

  List<String> item = ['beetroot','buy','carrot','garlic','nk','onions','vegetables-01','vegetables-02','vegetables-03'];

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FxColors.green600,
        elevation: 0.0,
        title: const Text(
          'Buyer',
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

      body:
      Scrollbar(
        child: GridView.builder(
          itemCount: 9,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: myCard(item[index]),
            );
          },
        ),
      ),
    );
  }

  Card myCard(String a) => Card(
    child: Column(
      children: [
        SizedBox(
          height: 130,
          child: Image.asset('assets/$a.jpg'),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: FxColors.green600,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bill()),
              );
            } ,
            child: Text('buy')
        ),
      ],
    ),
  );


}
