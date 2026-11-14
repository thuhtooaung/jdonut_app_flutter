class ProductArgs {
  final String? id;
  final String name;
  final String? discountTag;
  final String? price;
  final String? imageUrl;
  final String? description;
  final String? productCode;

  const ProductArgs({
    required this.name,
    this.id,
    this.discountTag,
    this.price,
    this.imageUrl,
    this.description,
    this.productCode,
  });
}
