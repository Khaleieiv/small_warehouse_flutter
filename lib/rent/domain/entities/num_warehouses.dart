class NumWarehouses {
  final int? warehouseId;
  final int size;
  final int price;
  final int humiditySensorId;
  final String description;
  final int containerStorageId;
  final int isRented;

  NumWarehouses(
    this.warehouseId,
    this.size,
    this.price,
    this.humiditySensorId,
    this.description,
    this.containerStorageId,
    this.isRented,
  );

  factory NumWarehouses.fromJson(Map<String, dynamic> json) {
    return NumWarehouses(
      json[_JsonFields.id],
      json[_JsonFields.size],
      json[_JsonFields.price],
      json[_JsonFields.humiditySensorId],
      json[_JsonFields.description],
      json[_JsonFields.containerStorageId],
      json[_JsonFields.isRented],
    );
  }
}

class _JsonFields {
  static const id = 'warehouse_id';
  static const size = 'size';
  static const price = 'price';
  static const humiditySensorId = 'humidity_sensor_id';
  static const description = 'description';
  static const containerStorageId = "container_storage_id";
  static const isRented = "is_rented";
}
