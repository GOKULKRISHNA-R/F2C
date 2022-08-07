import 'package:customize/customize.dart';
import 'package:flutter/material.dart';
import '../../additional files/constants.dart';
import '../../additional files/loading.dart';
import '../../services/auth.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ required this.toggleView });


  // const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false ;
  String error = '' ;
  String email = '' ;
  String password = '' ;

  @override
  Widget build(BuildContext context) {

    return loading ? const Loading() : Scaffold(

      // backgroundColor: FxColors.green50,

      appBar: AppBar(
        backgroundColor: FxColors.green600,
        elevation: 0.0,
        title: const Text(
          'Sign In',
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
              Icons.person_add_alt_1_outlined,
              color: Colors.black,
            ),
            label: const Text(
              'Register',
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

                  const SizedBox( height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.mail) ,
                    ) ,

                    validator: (val) => val!.isEmpty ? 'Enter an valid Email' : null  ,
                    onChanged: (val) {
                      setState(() {
                        email = val ;
                      });
                    },
                  ),

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

                  const SizedBox( height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[600],
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){

                        setState(() {
                          loading = true ;
                        });

                        dynamic result = await _auth.signinwithemailandpassword(email, password);

                        if(result == null)
                        {
                          setState(() {
                            error = 'could not sign in with your credentials' ;
                            loading = false ;
                          });
                        }
                      }
                    },

                    child: const Text(
                      'Sign in',
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