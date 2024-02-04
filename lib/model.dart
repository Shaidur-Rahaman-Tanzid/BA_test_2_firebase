class ItemModel {
  String? price;
  String? title;
  String? model;
  String? imageUrl;
  int? quantity;// New property for the image URL

  ItemModel({this.price, this.title, this.model, this.imageUrl, this.quantity});

  ItemModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    title = json['title'];
    model = json['model'];
    imageUrl = json['imageUrl'];
    quantity  =json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['title'] = this.title;
    data['model'] = this.model;
    data['imageUrl'] = this.imageUrl;
    data['quantity'] = this.quantity;
    return data;
  }
}