class CartDetail {
  CartDetail({
    this.id,
    this.idUser,
    this.idProduct,
    this.number,
    this.name,
    this.price,
    this.image,
  });

  String? id;
  String? idUser;
  String? idProduct;
  String? number;
  String? name;
  String? price;
  String? image;

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
        id: json["id"],
        idUser: json["idUser"],
        idProduct: json["idProduct"],
        number: json["number"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "idProduct": idProduct,
        "number": number,
        "name": name,
        "price": price,
        "image": image,
      };
}
