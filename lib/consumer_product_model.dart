class ConsumerProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  ConsumerProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory ConsumerProductModel.fromJson(String id, Map<String, dynamic> json) {
    return ConsumerProductModel(
      id: id,
      name: json['name'] ?? 'No Name',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}