import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance.collection('data');

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
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: firestore.snapshots(),
            builder: (context, snapshot) {
              double totalAmount = 0;
              List<DataItem> dataText = [];
              final dataCollection = snapshot.data.documents;
              for (var data in dataCollection) {
                final payee = data.data['payee'];
                final String ammount = data.data['ammount'];
                final title = data.data['title'];
                final date = data.data['date'];
                totalAmount += double.parse(ammount);

                print(payee);
                print(totalAmount);

                final textWidget = DataItem(
                  dTitle: title,
                  dAmount: ammount,
                  dPayee: payee,
                  dDate: date,
                  dTotal: totalAmount,
                );
                dataText.add(textWidget);
              }
              return Expanded(
                child: ListView(
                  children: dataText,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DataItem extends StatelessWidget {
  DataItem({this.dTitle, this.dPayee, this.dAmount, this.dDate, this.dTotal});
  final String dPayee;
  final String dAmount;
  final String dTitle;
  final String dDate;
  final double dTotal;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Text(
            'Title : $dTitle',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Amount : $dAmount'),
          SizedBox(
            height: 5,
          ),
          Text('Payed By : $dPayee'),
          SizedBox(
            height: 5,
          ),
          Text('Date : $dDate'),
        ],
      ),
    );
  }
}
