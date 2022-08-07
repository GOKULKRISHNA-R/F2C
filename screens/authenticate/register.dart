import 'package:customize/customize.dart';
import 'package:flutter/material.dart';
import '../../additional files/constants.dart';
import '../../additional files/loading.dart';
import '../../services/auth.dart';


class Register extends StatefulWidget {

  final Function toggleView;

  Register({ required this.toggleView });

  // const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false ;
  String error = '' ;
  String email = '' ;
  String password = '' ;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(

      backgroundColor: FxColors.green100 ,

      appBar: AppBar(
        backgroundColor: FxColors.green600 ,
        elevation: 0.0,
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            } ,
            icon: const Icon(
              Icons.login,
              color: Colors.black,
            ),
            label: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.black ,
              ),
            ) ,
          )
        ],

      ),

      body: Container(

          padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 50 ),

          child: Form(

              key: _formKey,

              child: Column(

                children:  <Widget>[

                  // NAME
                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'User Name',
                        prefixIcon: const Icon(Icons.person_pin_rounded)
                    ) ,

                    validator: (val) => val!.isEmpty ? 'Enter your Name' : null  ,
                  ),

                  // PHONE NUMBER
                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Phone Number',
                        prefixIcon: const Icon(Icons.call)
                    ) ,

                    validator: (val) => val!.length != 10 ? 'Enter an valid Mobile number' : null ,

                  ),

                  // EMAIL
                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.mail)
                    ) ,

                    validator: (val) => val!.isEmpty ? 'Enter an valid Email' : null  ,
                    onChanged: (val) {
                      setState(() {
                        email = val ;
                      });
                    },
                  ),

                  // PASSWORD
                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.vpn_key)
                    ) ,

                    validator: (val) => val!.length < 6 ? 'Enter an valid Password above 6 chars' : null ,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val ;
                      });
                    },
                  ),

                  // CONFIRM PASSWORD
                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.vpn_key)
                    ) ,

                    validator: (val) => val != password ? 'Enter an Same Password ' : null ,
                    obscureText: true,

                  ),

                  const SizedBox( height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: FxColors.green600,
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                        setState(() {
                          loading = true ;
                        });

                        dynamic result = await _auth.registerwithemailandpassword(email, password);

                        if(result == null)
                        {
                          setState(() {
                            error = 'please enter valid email' ;
                            loading = false ;
                          });
                        }
                      }
                    },

                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white ,
                        fontSize: 18 ,
                      ),
                    ),
                  ),

                  const SizedBox( height: 20,),
                  Text(
                    error,
                    style: const TextStyle(
                      color: Colors.red ,
                      fontSize: 14 ,
                    ),
                  ),

                ],
              )

          )
      ),
    );
  }
}
