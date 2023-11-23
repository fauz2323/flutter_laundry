class KeuanganModel {
  int? id;
  String type;
  String desc;
  int amount;
  String date;

  KeuanganModel({
    this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.desc,
  });

  factory KeuanganModel.fromMap(Map<String, dynamic> map) {
    return KeuanganModel(
      id: map['id'],
      type: map['type'],
      desc: map['desc'],
      amount: map['amount'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
      'desc': desc,
    };
  }
}
