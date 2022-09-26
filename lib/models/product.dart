class Product {
  late final String name;
  late final String cost;

  Product({required this.name, required this.cost});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cost'] = this.cost;
    return data;
  }
}
