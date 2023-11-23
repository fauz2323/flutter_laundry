class TransactionModel {
  int? id;
  String type;
  String destination;
  int amount;
  String date;

  TransactionModel(
      {this.id,
      required this.type,
      required this.destination,
      required this.amount,
      required this.date});

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      type: map['type'],
      destination: map['destination'],
      amount: map['amount'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'destination': destination,
      'amount': amount,
      'date': date,
    };
  }
}
