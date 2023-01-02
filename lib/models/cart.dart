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

  Map<String, dynamic> toOrderJson({required String idUser}) => {
        "idUser": int.parse(idUser),
        "idProduct": int.parse(idProduct!),
        "number": int.parse(number!),
        "name": name,
        "price": int.parse(price!),
        "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
      };
  factory CartDetail.copyWith(CartDetail? cartDetail) => CartDetail(
        id: cartDetail?.id,
        idUser: cartDetail?.idUser,
        idProduct: cartDetail?.idProduct,
        number: cartDetail?.number,
        name: cartDetail?.name,
        price: cartDetail?.price,
        image: cartDetail?.image,
      );

  // factory CartDetail.apply({
  //   String? id,
  //   String? idUser,
  //   String? idProduct,
  //   String? number,
  //   String? name,
  //   String? price,
  //   String? image,
  // }) =>
  //     CartDetail(
  //       id: id,
  //       idUser: idUser,
  //       idProduct: idProduct,
  //       number: number,
  //       name: name,
  //       price: price,
  //       image: image,
  //     );
}
