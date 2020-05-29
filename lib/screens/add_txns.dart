//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:expense_log/expense_item.dart';
import 'package:flutter/material.dart';
import '../models/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class AddTxnScreen extends StatefulWidget {
  @override
  _AddTxnScreenState createState() => _AddTxnScreenState();
}

class _AddTxnScreenState extends State<AddTxnScreen> {
  String selectedDate = DateFormat.yMMMd().format(DateTime.now()).toString();
  String dropDownSelected = 'Ananthu';
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var isSubmitting = false;

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
      ),
      body: isSubmitting ? Center(child: CircularProgressIndicator(),): Column(
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
                  icon: Icon(Icons.arrow_drop_down_circle,
                      size: 30, color: Colors.green),
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
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
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
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  selectedDate,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              FlatButton(
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now().toLocal(),
                      firstDate: DateTime.utc(2019),
                      lastDate: DateTime.now()).then((pickedDate){
                        setState(() {
                          selectedDate = DateFormat.yMMMd().format(pickedDate).toString();
                          print(selectedDate);
                        });
                  });
                },
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: () {
                  if ((title == null || title == '') ||
                      (amount == null ||
                          amount == '' ||
                          (double.tryParse(amount) == null))) {
                    Toast.show('Enter valid data', context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  } else {
                    setState(() {
                      isSubmitting = true;
                    });
                    var docId = DateTime.now().toString();
                    documentReference.document(docId).setData({
                      'id' : docId,
                      'payee': dropDownSelected,
                      'title': title,
                      'ammount': amount,
                      'date': selectedDate
                    }).whenComplete(() {
                      titleController.clear();
                      amountController.clear();

                      Toast.show("Added Successfully", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                      Navigator.pop(context);
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    titleController.dispose(); //disposing controllers to prevent memory leaks and improve performance.
    amountController.dispose();
    super.dispose();
  }

}
