class HomeModel{
  bool? status;
  DataHomeModel? data;
  HomeModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    data = DataHomeModel.fromjson(json['data']);
  }
}
class DataHomeModel{
 late List <BannersModel> banners=[];
 late List <ProductsModel> products=[];
DataHomeModel.fromjson(Map<String,dynamic>json){
json['banners'].forEach((element) {
  banners.add(BannersModel.fromjson(element));
});
json['products'].forEach((element) {
  products.add(ProductsModel.fromjson(element));
});
}
}
class BannersModel{
  int? id;
  String? image;
  BannersModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    image= json['image'];
  }
}
class ProductsModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;
  ProductsModel.fromjson(Map<String,dynamic>json){
    id = json['id'];
    price=json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image= json['image'];
    name= json['name'];
    inFavorite= json['in_favorites'];
    inCart = json['in_cart'];
  }
}
