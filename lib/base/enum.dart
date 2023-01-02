enum FromWhere {
  fromLoginNormal,
  fromBuyProduct,
}

enum LocalStorage {
  carts(name: 'carts'),
  user(name: 'usesr');

  final String name;

  const LocalStorage({required this.name});
}

enum DialogType {
  loginFail,
  emptyCart,
  mustLogin,
  addCartSuccess,
  logout,
  addOrderSuccess,
}
