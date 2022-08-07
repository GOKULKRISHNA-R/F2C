import 'package:customize/customize.dart';
import 'package:f2c/screens/home/B_home.dart';
import 'package:f2c/screens/home/F_home.dart';
import 'package:f2c/screens/home/addYeild.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


enum FarBuy { farmer, buyer }

class _HomeState extends State<Home> {

  Object? _site = FarBuy.farmer ;


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlertDialog(context));
    return
      Container(
      color: FxColors.green100,
    );
  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green[600],
      ),
      child: const Text(
          "Submit",
          style: TextStyle(
            color: Colors.black
          ),
      ),
      onPressed: () {
        if(_site == FarBuy.farmer){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Farmer()),
          );
        }else if(_site == FarBuy.buyer){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Buyer()),
          );
        }
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.greenAccent,
      content: Container(
        height: 200,
        child: Column(

          children: [
            const SizedBox( height: 20,),
            ListTile(
              title: const Text('Farmer'),
              leading: Radio(
                value: FarBuy.farmer,
                groupValue: _site,
                onChanged: (value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),

            ListTile(
              title: const Text('Buyer'),
              leading: Radio(
                value: FarBuy.buyer,
                groupValue: _site,
                onChanged: (value) {
                  setState(() {
                    _site = value;
                  });
                },
              ),
            ),

          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}