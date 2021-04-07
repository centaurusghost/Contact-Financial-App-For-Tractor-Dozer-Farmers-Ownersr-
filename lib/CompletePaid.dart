import 'package:flutter/material.dart';
import 'package:clean_app/DatabaseHelper.dart';
import 'package:clean_app/Contact.dart';
class CompletePaid extends StatefulWidget {
  @override
  _UnpaidContactsState createState() => _UnpaidContactsState();
}

class _UnpaidContactsState extends State<CompletePaid> {
  DatabaseHelper unpaidHelper = DatabaseHelper();
  List<Contact> unpaidList =[];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
