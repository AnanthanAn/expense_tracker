//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:expense_log/expense_item.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownSelected = 'Ananthu';
  final titleController = TextEditingController();
  final amountController = TextEditingController();
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
        title: Text('Expense Tracker'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    color: Colors.brown
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
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: titleController,
              decoration: InputDecoration(
                icon: Icon(Icons.shopping_cart,color: Colors.brown,),
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              onChanged: (value) {
                title = value;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: amountController,keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(Icons.attach_money,color: Colors.brown,),
                  border: OutlineInputBorder(),
                  labelText: 'Amount'),
              onChanged: (value) {
                amount = value;
              },
            ),
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
                  if((title == null || title =='') && (amount == null || amount == '')){
                    Toast.show('Enter something', context,duration: Toast.LENGTH_SHORT,gravity: Toast.CENTER);
                  }else{
                    documentReference.add({
                      'payee': dropDownSelected,
                      'title': title,
                      'ammount': amount,
                      'date': new DateFormat.yMMMd().format(new DateTime.now()).toString()
                    }).whenComplete((){
                      titleController.clear();
                      amountController.clear();

                      Toast.show("Added Successfully", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);


                    });
                  }


                }),
          ),
        ],
      ),
    );
  }
}
