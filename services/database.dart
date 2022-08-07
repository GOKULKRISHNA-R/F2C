import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DBService {

  final String uid ;
  DBService({ required this.uid });

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Gk');

  Future updateUserData(String UserName , String PhoneNumber ) async {
    return await userCollection.doc(uid).set({
      'UserName': UserName,
      'PhoneNumber': PhoneNumber,
    });
  }

}

class DBStorage {
  static UploadTask? uploadFile(String destination , File file){
    try{
      final ref = FirebaseStorage.instance.ref(destination) ;
      return ref.putFile(file);
    } on FirebaseException catch(e){
      return null ;
    }
  }
}