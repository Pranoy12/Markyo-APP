class User {
  late final String name;
  late final String password;
  late final String email;
  late final List<dynamic> cart;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.cart});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    cart = json['cart'];
  }

  get token => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['cart'] = this.cart;
    return data;
  }
}
