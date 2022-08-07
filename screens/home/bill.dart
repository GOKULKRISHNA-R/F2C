import 'package:customize/customize.dart';
import 'package:f2c/additional%20files/constants.dart';
import 'package:flutter/material.dart';

class Bill extends StatefulWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {

  String _pay = '' ;
  List<String> way = ['Select Payment Method','Internet banking','Debit Card','Credit Card','UPI','Gpay','Amazon Pay'];

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
      ),
      body: Container(
        color: FxColors.green200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: (
          Form(
            child:
            Column(
              children: [
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Quantity in Kgs',
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Address',
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: 20,),

                DropdownButtonFormField<String>(
                  dropdownColor: Colors.green,
                  value: 'Select Payment Method' ,
                  onChanged:  (val) => setState(() => _pay = val! ) ,
                  decoration: textInputDecoration,
                  items: way.map((e) => DropdownMenuItem<String>(value: e,child: Text(e)) ).toList(),

                ),

              ],
            ),
          )
          ),
        ),
      ),
    );
  }
}
