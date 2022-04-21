import 'package:basicbanksystem/Screen1.dart';
import 'package:basicbanksystem/Variables.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomerInformation extends StatefulWidget {
  String pageId;
  List customers;

  CustomerInformation(this.pageId, this.customers);

  @override
  CustomerInformationState createState() =>
      CustomerInformationState(this.pageId, customers: this.customers);
}

class CustomerInformationState extends State<CustomerInformation> {
  String pageId;
  List customers;
  int transmissionValue;

  CustomerInformationState(this.pageId, {this.customers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Customers - $pageId'),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, position) {
          //print(customers[position]['balance'].runtimeType);
          return GestureDetector(
            onTap: () {
              if (pageId == 'Sender') {
                senderID = customers[position]['id'];
                print(senderID);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return CustomerInformation('Receiver', customers);
                  }),
                );
              } else {
                receiverID = customers[position]['id'];
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Enter Transfer Money Value'),
                    content: TextField(
                      onChanged: (value) {
                        transmissionValue = int.parse(value);
                      },
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          update(
                              customers[position]['balance'] -
                                  transmissionValue,
                              senderID);
                          update(
                              customers[position]['balance'] +
                                  transmissionValue,
                              receiverID);
                          print('update');

                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Succeeded Transfer'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CustomerInformation(
                                                'Sender', customers);
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text('New Transfer'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Screen1();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('confirm'),
                      ),
                    ],
                  ),
                );
                const Text('Show Dialog');
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.all(15.0),
              shadowColor: Colors.teal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Name: ${customers[position]['name']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Acme',
                      ),
                    ),
                    Text(
                      "Balance: ${customers[position]['balance'].toString()}",
                      style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Acme',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void update(int balance, int id) async {
    await database.rawUpdate('UPDATE Customers SET balance = ? WHERE id = ?',
        [balance, id]).then((value) {
      print('Done');
    });
  }
}
