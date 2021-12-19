class SearchModel{
  bool? status;
  Data? data;
  SearchModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data = Data.fromjson(json['data']);
  }
}
class Data{
  int? currentPage;
  late List<ProductData> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? LastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? totaa;
 Data.fromjson(Map<String,dynamic>json){
   currentPage = json['current_page'];
   json['data'].forEach((element) {
     data.add(ProductData.fromjson(element));
   });
   firstPageUrl = json['first_page_url'];
   from =json['from'];
   lastPage =json['last_page'];
   LastPageUrl =json['last_page_url'];
   path =json['path'];
   perPage = json['per_page'];
   to =json['to'];
   totaa =json['total'];
 }
}
class ProductData{
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? images;
  bool? inFavourite ;
  bool? inCart;
  ProductData.fromjson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    images = json['description'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}