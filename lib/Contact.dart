class Contact {
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colPhone = 'phone';
  static const colTime = 'time';
  static const colCostPerHour = 'costperhour';
  static const colPaidAmount = 'paidamount';
  static const colTotal = 'total';
  static const colRemaining = 'remaining';

  int id;
  String name, phone, time, costperhour, paidamount, total, remaining;

  Contact(
      {this.id,
      this.name,
      this.phone,
      this.time,
      this.costperhour,
      this.paidamount,
      this.total,
      this.remaining});
  Contact.withId(
      {this.id,
        this.name,
        this.phone,
        this.time,
        this.costperhour,
        this.paidamount,
        this.total,
        this.remaining});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colName: name,
      colPhone: phone,
      colTime: time,
      colCostPerHour: costperhour,
      colPaidAmount: paidamount,
      colTotal: total,
      colRemaining: remaining
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }

  Contact.fromMap(Map<String, dynamic>map){
    id = map[colId];
    name = map[colName];
    phone = map[colPhone];
    time = map[colTime];
    costperhour = map[colCostPerHour];
    paidamount = map[colPaidAmount];
    total = map[colTotal];
    remaining = map[colRemaining];
  }

}