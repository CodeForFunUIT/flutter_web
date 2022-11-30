class Banner {
  String? id;
  String? image;
  String? idProduct;

  Banner({
    this.id,
    this.image,
    this.idProduct,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json['id'] ?? '0',
        image: json['image'] ?? '',
        idProduct: json['idProduct'] ?? '0',
      );
}
