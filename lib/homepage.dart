//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:expense_log/expense_item.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownSelected = 'Ananthu';
  String title;
  String amount;
  final CollectionReference documentReference =
      Firestore.instance.collection('data');

  List<DropdownMenuItem<String>> getDropdownMenu() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String name in flatMates) {
      dropdownMenuItems.add(DropdownMenuItem(
        child: Text(name),
        value: name,
      ));
    }

    return dropdownMenuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Log'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: dropDownSelected,
                items: getDropdownMenu(),
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
                elevation: 10,
                icon: Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                  color: Colors.brown,
                ),
                //hint: Text('Payed by'),
                //iconEnabledColor: Colors.white,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    dropDownSelected = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.shopping_cart),
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
            onChanged: (value) {
              title = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                icon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
                labelText: 'Amount'),
            onChanged: (value) {
              amount = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: Text('Date : '+new DateFormat.yMMMd().format(new DateTime.now()).toString(),style: TextStyle(fontSize: 16),)),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                child: Text('Save',style: TextStyle(color: Colors.white),),
                color: Colors.brown,
                onPressed: () {



                  documentReference.add({
                    'payee': dropDownSelected,
                    'title': title,
                    'ammount': amount,
                    'date': new DateFormat.yMMMd().format(new DateTime.now()).toString()
                  });
                }),
          ),
        ],
      ),
    );
  }
}
