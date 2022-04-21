class Customer {
  String name;
  String email;
  int balance;

  Customer(this.name, this.email, this.balance);

  void setName(String n) {
    name = n;
  }

  void setBalance(int b) {
    balance = b;
  }

  String getName() {
    return name;
  }

  int getBalance() {
    return balance;
  }
}
