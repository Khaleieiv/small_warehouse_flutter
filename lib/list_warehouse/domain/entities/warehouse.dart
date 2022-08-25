class Warehouse {
  final int? numWarehouse;
  final int size;
  final int price;
  final int humidity;
  final String description;

  Warehouse(this.numWarehouse, this.size, this.price, this.humidity,
      this.description);

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      json[_JsonFields.id],
      json[_JsonFields.size],
      json[_JsonFields.price],
      json[_JsonFields.humidity],
      json[_JsonFields.description],
    );
  }
}

class _JsonFields {
  static const id = 'warehouse_id';
  static const size = 'size';
  static const price = 'price';
  static const humidity = 'humidity';
  static const description = 'description';
}
