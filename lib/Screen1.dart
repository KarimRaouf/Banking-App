import 'package:basicbanksystem/CutomerInformation.dart';
import 'package:basicbanksystem/NewAccount.dart';
import 'package:flutter/material.dart';
import 'Model/Customer.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  List<Customer> customers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bank System App',
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Basic Banking System',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Image(
                image: AssetImage('Images/logo.png'),
                height: 350,
                width: 350,
              ),
              SizedBox(
                height: 70.0,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'View Customers',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return CustomerInformation('Sender', customers);
                    }),
                  );
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Add Customer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return NewAccount();
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
