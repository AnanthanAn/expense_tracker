import 'package:expense_tracker/screens/add_txns.dart';
import 'package:expense_tracker/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:expense_tracker/models/data_item.dart';

final firestore = Firestore.instance.collection('data');

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String total;
  @override
  void initState() {
    super.initState();
  }

  void getTotal(ammount) {
    Alert(context: context, title: "Total", desc: total.toString()).show();
  }

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
          StreamBuilder<QuerySnapshot>(
            stream: firestore.orderBy('id').snapshots(),
            builder: (context, snapshot) {
              List<DataItem> dataText = [];
              double totalAmount = 0;
              final dataCollection = snapshot.data.documents;
              for (var data in dataCollection) {
                final id = data.data['id'];
                final payee = data.data['payee'];
                final String ammount = data.data['ammount'];
                final title = data.data['title'];
                final date = data.data['date'];

                totalAmount += double.parse(ammount);
                total = totalAmount.toStringAsFixed(2);
                //print(payee);
                print(totalAmount);

                final textWidget = DataItem(
                  dId:  id,
                  dTitle: title,
                  dAmount: ammount,
                  dPayee: payee,
                  dDate: date,
                  //dTotal: totalAmount,
                );
                dataText.add(textWidget);
              }
              return Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemBuilder: (context, idx) {
                        return ListTileItem(
                          id: dataText[idx].dId,
                            title: dataText[idx].dTitle,
                            amount: dataText[idx].dAmount,
                            payee: dataText[idx].dPayee,
                            date: dataText[idx].dDate);
                      },
                      itemCount: dataText.length,
                    )

//                  ListView(
//                    children: dataText,
//                  ),
                    ),
              );
            },
          ),
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
                    getTotal(total);
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
