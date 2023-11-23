class StockModel {
  int? id;
  int amount;
  String desc;
  String date;
  String type;

  StockModel(
      {this.id,
      required this.amount,
      required this.date,
      required this.desc,
      required this.type});

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'],
      amount: map['amount'],
      date: map['date'],
      desc: map['desc'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
      'desc': desc,
      'type': type,
    };
  }
}
