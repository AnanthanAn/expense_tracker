import 'package:expense_tracker/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    Alert(context: context, title: "Total", desc: "$total").show();
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
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: firestore.snapshots(),
            builder: (context, snapshot) {
              List<DataItem> dataText = [];
              double totalAmount = 0;
              final dataCollection = snapshot.data.documents;
              for (var data in dataCollection) {
                final payee = data.data['payee'];
                final String ammount = data.data['ammount'];
                final title = data.data['title'];
                final date = data.data['date'];

                totalAmount += double.parse(ammount);
                total = totalAmount.toString();
                //print(payee);
                print(totalAmount);

                final textWidget = DataItem(
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
                        return ListTile(
                          leading: CircleAvatar(radius: 30,
                            child: Text('₹ ${dataText[idx].dAmount.toString()}',style: TextStyle(fontWeight: FontWeight.bold,),),
                          ),
                          title: Text('${dataText[idx].dTitle}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
                          subtitle: Text('${dataText[idx].dPayee}',style: TextStyle(fontSize: 16),),
                          trailing: Text('${dataText[idx].dDate}',style: TextStyle(fontSize: 18),),
                        );
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
          Center(child: Text('Version 0.2.1 (Beta) \n     © Ananthan')),
        ],
      ),
    );
  }
}

class DataItem {
  DataItem({this.dTitle, this.dPayee, this.dAmount, this.dDate, this.dTotal});
  final String dPayee;
  final String dAmount;
  final String dTitle;
  final String dDate;
  final double dTotal;
}
