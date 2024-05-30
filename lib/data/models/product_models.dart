class Product {
  final int? id;
  final String? code;
  final String description;
  final double? price;
  final int? quantity;

  Product({
    this.id,
    this.code,
    required this.description,
    this.price,
    this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'price': price,
      'quantity': quantity
    };
  }
}
