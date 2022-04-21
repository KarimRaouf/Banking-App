import 'package:basicbanksystem/CutomerInformation.dart';
import 'package:basicbanksystem/Model/Customer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Variables.dart';

class NewAccount extends StatefulWidget {
  @override
  _NewAccountState createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  String name;
  int initialBalance;
  List customers;

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Customers"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  //controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onChanged: (value) {
                    name = value;
                    print(name);
                  },
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Your Initial Balance',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  onChanged: (value) {
                    initialBalance = int.parse(value);
                  },
                ),
                SizedBox(
                  height: 80.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    insertDataBase(
                      Customer(name, "email", initialBalance),
                    );
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 200.0),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () async {
                    await getCustomers(database).then((value) {
                      customers = value;
                      print(customers);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return CustomerInformation('Sender', customers);
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createDatabase() async {
    database = await openDatabase(
      'customers.db',
      version: 2,
      onCreate: (database, version) async {
        print('DB created');
        await database
            .execute(
                'CREATE TABLE Customers (id INTEGER PRIMARY KEY, name TEXT, email TEXT, balance INTEGER)')
            .then((value) {
          print('table created');
        });
      },
      onOpen: (database) {
        getCustomers(database);
        print('DB opened');
      },
    );
  }

  void insertDataBase(Customer customer) {
    database.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO Customers(name,email,balance) VALUES("${customer.name}","${customer.email}","${customer.balance}")',
      )
          .then((value) {
        print('$value insertion succeeded');
      });
      return null;
    });
  }

  Future<List<Map>> getCustomers(database) async {
    customers = await database.rawQuery('SELECT * FROM Customers');
    return customers;
  }
}
