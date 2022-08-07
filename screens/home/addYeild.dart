import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:customize/customize.dart';
import 'package:f2c/services/database.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../additional files/constants.dart';
import 'package:path/path.dart';

class AddYeild extends StatefulWidget {
  const AddYeild({Key? key}) : super(key: key);

  @override
  _AddYeildState createState() => _AddYeildState();
}

class _AddYeildState extends State<AddYeild> {

  File? file ;
  DateTime? selecteddate ;
  final _formKey = GlobalKey<FormState>();
  String _product = '' ;
  String _amt = '' ;


  @override
  Widget build(BuildContext context) {

    final filename = file!= null ? basename(file!.path) : 'No File Setected' ;

    return Scaffold(
      appBar:  AppBar(

          backgroundColor: FxColors.green600,
          elevation: 0.0,
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey ,
          child: Column(
            children: [
            const SizedBox( height: 20,),
          TextFormField(
            decoration: textInputDecoration.copyWith(
              hintText: 'Product',
              prefixIcon: const Icon(Icons.production_quantity_limits_rounded) ,
            ) ,

            validator: (val) => val!.isEmpty ? 'Enter Product Name' : null  ,
            onChanged: (val) {
              _product = val ;
            },
          ),

          const SizedBox( height: 20,),
          TextFormField(
            decoration: textInputDecoration.copyWith(
                hintText: 'Amount per Quintal',
                prefixIcon: const Icon(Icons.money_rounded)
            ) ,
            validator: (val) => val!.isEmpty ? 'Enter Price' : null  ,
            onChanged: (val) {
              _amt = val ;
            },
          ),

              const SizedBox( height: 20,),
              DateTimeField(
                decoration: textInputDecoration.copyWith(hintText: 'Select Expiry Date',prefixIcon: const Icon(Icons.date_range)),
                  onDateSelected: (DateTime val) {
                    setState(() {
                      selecteddate = val ;
                    });
                  },
                  selectedDate: selecteddate
              ),

              const SizedBox( height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[600],
                ),
                onPressed: () async {

                  final result = await FilePicker.platform.pickFiles(allowMultiple: false) ;

                  if(result == null) return ;

                  final path = result.files.single.path! ;

                  setState(() {
                    file = File(path) ;
                  });

                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.attach_file,),
                    Text('Select Product Images From Device'),
                  ],
                ),
              ),
              Text(
                filename,
                style: const TextStyle(
                  // color: Colors.red,
                ),
              ),

              const SizedBox( height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[600],
                ),
                onPressed: ()
                async {

                  if(_formKey.currentState!.validate()) {

                    if(file == null) return ;

                    final filename = basename(file!.path) ;
                    final destination = "files/$filename";

                    var task = DBStorage.uploadFile(destination, file!);

                    // if(task == null) return ;
                    //
                    // final snapshot = await task.whenComplete(() => null);
                    //
                    // final urlD = await snapshot.ref.getDownloadURL();
                    //
                    // print(urlD);

                  }

                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.drive_folder_upload,),
                    Text(' Upload File'),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              // Load() ,

            ],
          ),
        ),
      ),
    );
  }
}


//
//   Widget Load () {
//
//     if(load == false){
//       return const Loading();
//     }
//
//     return Container();
//   }
//

  // Widget buildUploadState (UploadTask task) => StreamBuilder<TaskSnapshot>(
  //     stream: task.snapshotEvents,
  //     builder: (context,snapshot) {
  //       if(snapshot.hasData) {
  //          final snap = snapshot.data! ;
  //          final progress = snap.bytesTransferred / snap.totalBytes ;
  //
  //          return Text(
  //            '$progress %',
  //             style: const TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold ,
  //             ),
  //
  //          );
  //       }else {
  //         return Container() ;
  //       }
  //     }
  // );
