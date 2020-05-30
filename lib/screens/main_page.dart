import 'package:expense_tracker/screens/add_txns.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTxnScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          TransactionList(),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    Alert(
                        context: context,
                        title: 'Sherikkum ?',
                        desc: 'Onnude aalojichu nokkikke',
                        buttons: [
                          DialogButton(
                              child: Text('Yep'),
                              onPressed: () {
                                firestore.document('data').delete();
                              }),
                        ]).show();
                  },
                  child: Text(
                    'Delete All',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    //getAndSetUsers(context);
                    TransactionList().getTotal(context);
                  },
                  child: Text(
                    'View Total',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          Center(child: Text('Version 1.1.0 (Beta) \n     © Ananthan')),
        ],
      ),
    );
  }
}
