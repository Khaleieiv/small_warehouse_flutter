class Rent {
  final String userName;
  final String userPhone;
  final String userEmail;
  final int warehouseSize;
  final int warehousePrice;
  final DateTime dateStart;
  final DateTime dateFinish;

  Rent(
    this.userName,
    this.userPhone,
    this.userEmail,
    this.warehouseSize,
    this.warehousePrice,
    this.dateStart,
    this.dateFinish,
  );

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      json[_JsonFields.userName],
      json[_JsonFields.userPhone],
      json[_JsonFields.userEmail],
      json[_JsonFields.warehouseSize],
      json[_JsonFields.warehousePrice],
      json[_JsonFields.dateStart],
      json[_JsonFields.dateFinish],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _JsonFields.userName: userName,
      _JsonFields.userPhone: userPhone,
      _JsonFields.userEmail: userEmail,
      _JsonFields.warehouseSize: warehouseSize,
      _JsonFields.warehousePrice: warehousePrice,
      _JsonFields.dateStart: dateStart.toIso8601String(),
      _JsonFields.dateFinish: dateFinish.toIso8601String(),
    };
  }
}

class _JsonFields {
  static const userName = 'userName';
  static const userPhone = 'userPhone';
  static const userEmail = 'userEmail';
  static const warehouseSize = 'warehouseSize';
  static const warehousePrice = 'warehousePrice';
  static const dateStart = 'date_start';
  static const dateFinish = 'date_finish';
}