// class FavouriteScreenModel {
//   bool? status;
//   Data2? data;
//
//   FavouriteScreenModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = (json['data'] != null ? new Data2.fromJson(json['data']) : null)!;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? currentPage;
//   List<Data2>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;
//
//
//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = new List<Data2>();
//       json['data'].forEach((v) {
//         data!.add(new Data2.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class Data2 {
//   int? id;
//   Product? product;
//
//   Data2.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product =
//     json['product'] != null ? new Product.fromJson(json['product']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     return data;
//   }
// }
//
// class Product {
//   int? id;
//   double? price;
//   double? oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['price'] = this.price;
//     data['old_price'] = this.oldPrice;
//     data['discount'] = this.discount;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     return data;
//   }
// }

// class FavouriteScreenModel {
//
//   late final bool status;
//   late final Null message;
//   late final Data data;
//
//   FavouriteScreenModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     message = null;
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['message'] = message;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });
//   late final int currentPage;
//   late final List<Data> data;
//   late final String firstPageUrl;
//   late final int from;
//   late final int lastPage;
//   late final String lastPageUrl;
//   late final Null nextPageUrl;
//   late final String path;
//   late final int perPage;
//   late final Null prevPageUrl;
//   late final int to;
//   late final int total;
//
//   Data.fromJson(Map<String, dynamic> json){
//     currentPage = json['current_page'];
//     data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = null;
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = null;
//     to = json['to'];
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['current_page'] = currentPage;
//     _data['data'] = data.map((e)=>e.toJson()).toList();
//     _data['first_page_url'] = firstPageUrl;
//     _data['from'] = from;
//     _data['last_page'] = lastPage;
//     _data['last_page_url'] = lastPageUrl;
//     _data['next_page_url'] = nextPageUrl;
//     _data['path'] = path;
//     _data['per_page'] = perPage;
//     _data['prev_page_url'] = prevPageUrl;
//     _data['to'] = to;
//     _data['total'] = total;
//     return _data;
//   }
// }

class FavouriteScreenModel{
  bool? status;
  FavouriteScreenDataModel? data;
  FavouriteScreenModel.fromjson(Map<String,dynamic>json){
    status= json['status'];
    data = FavouriteScreenDataModel.fromjson(json['data']);

  }

}
class FavouriteScreenDataModel{
  int? currentPage;
  late List<DataList> data = [];
  String? first_page_url;
  int? from;
  int? last_page;
  String? last_page_url;
  String? path;
  int? per_page;
  int? to;
  int? total;
  FavouriteScreenDataModel.fromjson(Map<String,dynamic>json){
    currentPage = json['current_page'];
     json['data'].forEach((element) {
       data.add(DataList.fromjson(element));
     });
     first_page_url = json['first_page_url'];
     from = json['from'];
     last_page = json['last_page'];
     last_page_url = json['last_page_url'];
     path = json['path'];
     per_page = json['per_page'];
     to = json['to'];
     total = json['total'];
  }
}
class DataList{
  int? id;
  ProductDataInFavourite? productData;
  DataList.fromjson(Map<String,dynamic>json){
    id = json['id'];
    productData = ProductDataInFavourite.fromjson(json['product']);
  }
}
class ProductDataInFavourite{
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String?  description;
  ProductDataInFavourite.fromjson(Map<String,dynamic>json){
     id = json['id'];
     price = json['price'];
     old_price = json['old_price'];
     discount = json['discount'];
     image = json['image'];
     name = json['name'];
     description = json['description'];
  }
  
}