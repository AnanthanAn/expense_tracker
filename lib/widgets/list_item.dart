import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final String id;
  final String title;
  final String payee;
  final String date;
  final String amount;

  ListTileItem(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.payee,
      @required this.date});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.delete,color: Colors.white70,size: 30,),
      ),alignment: Alignment.centerRight,
        color: Colors.redAccent,
      ),
      direction: DismissDirection.endToStart,onDismissed:(_){
        Firestore.instance.collection('data').document(id).delete().catchError((error){
          print('Error - - - - - --- ${error.toString()}');
        });
    },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(
              '₹ ${amount.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        subtitle: Text(
          payee,
          style: TextStyle(fontSize: 16),
        ),
        trailing: Text(
          date,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
