import 'package:flutter/material.dart';
import 'package:customize/customize.dart';

const textInputDecoration = InputDecoration(
  prefixIconColor: Colors.black,
  fillColor: FxColors.green50,
  enabledBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: FxColors.green50 ,width: 2 )
  ),
  focusedBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: FxColors.gray500,width: 2 )
  ),
  filled: true,
);