
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/dio_helper.dart';
import 'package:shop_app/medules/screens/Update_screen.dart';
import 'package:shop_app/medules/screens/categories_screen.dart';
import 'package:shop_app/medules/screens/favourite_screen.dart';
import 'package:shop_app/medules/screens/product_screen.dart';
import 'package:shop_app/medules/screens/profile_screen.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/favourites_screen_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/end_point/end_point.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{
  ShopAppCubit() : super (InitShopState());
  static ShopAppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  AppBar appBar(context)=>AppBar(title: const Text('profile',
    style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        letterSpacing: 1,
        color: Colors.black
    ),
  ),actions: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(onPressed: (){
        goTo(context, UpdateScreen());
      }, child: const Text('edit',style: TextStyle(
fontSize: 20.0,
letterSpacing: 1,
),)),
    )
  ],);
List <Widget> currentScreen = [
  const ProductScreen(),
  const CategoryScreen(),
  const FavouriteScreen(),
  const ProfileScreen(),
];
void changeBottomNav({required int index}){
  currentIndex = index;
  emit(ChangeBottomNavtShopState());
}

void getNewData({String? newtoken}){
  homeScreen();
  productFavourite();
  getFavourite();
  getProfile();
}
   HomeModel?  homeModel;
  Map <int?,bool?> favouriteMap = {};
void homeScreen({String? newtoken}){
  emit(ShopAppLoadingDataState());
  DioHelper.getData(
      url: HOME,
      token: newtoken?? token
  ).then((value) {
    homeModel = HomeModel.fromjson(value.data);
    print(homeModel!.status);

    for (var element in homeModel!.data!.products) {
      favouriteMap.addAll({element.id : element.inFavorite});

    }
    emit(ShopAppSccessDataState());
  }).catchError((onError){
    print(onError.toString());
    emit(ShopAppErrorDataState(onError.toString()));
  });
}

CategoriesModel? categoriesModel;
void getCategories(){
  print(token);
  DioHelper.getData(
      url: GET_CATEGORIES
  ).then((value) {
    categoriesModel = CategoriesModel.fromjson(value.data);
    emit(ShopAppSccessCategoriesDataState());

  }).catchError((onError){
    emit(ShopAppErrorCategoriesDataState(onError.toString()));
    print(onError.toString());
  });
}

FavouriteModel? favouriteModel;
void productFavourite({int? id,String? newtoken}){
  if(favouriteMap[id]== true){
    favouriteMap[id] = false;
  }else{
    favouriteMap[id] = true ;
  }
  emit(ShopAppChangeIconDataState());
  DioHelper.postData(
      url: FAVOURITE,
      data:
      {'product_id': id},
      token:newtoken?? token
  ).then((value) {
    favouriteModel =FavouriteModel.fromjson(value.data);
    print(value.data);
    if (favouriteModel!.status ==false){
      if(favouriteMap[id]== true){
        favouriteMap[id] = false;
      }else{
        favouriteMap[id]=true;
      }
    }else{
      getFavourite();
    }
    emit(ShopAppSccessFavouriteDataState(favouriteModel!));
  }).catchError((onError){
    if(favouriteMap[id]== true){
      favouriteMap[id] = false;
    }else{
      favouriteMap[id] = true ;
    }
    print(onError.toString());
    emit(ShopAppErroFavouriteDataState(onError.toString()));
  });
}

  FavouriteScreenModel? favouriteScreenModel;
  void getFavourite({String? newtoken}){
    emit(ShopAppLoadingGetFavouriteDataState());
    DioHelper.getData(
        url: FAVOURITE,
        token: newtoken?? token
    ).then((value) {
      //print(value.data);
      favouriteScreenModel = FavouriteScreenModel.fromjson(value.data);
      emit(ShopAppSccessGetFavouriteDataState());

    }).catchError((onError){
      emit(ShopAppErrorGetFavouriteDataState(onError.toString()));
      print(onError.toString());
    });
  }

   LoginModel? homeUserModel;
  void getProfile({String? newtoken}){
    emit(ShopAppLoadingProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: newtoken?? token,
    ).then((value) {
      homeUserModel =LoginModel.jsonData(value.data);
      var userData = homeUserModel!.data;
      emit(ShopAppGetUserDataState(userData!));
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    }).catchError((onError){
      print(onError.toString());
      emit(ShopAppErrorGetUserDataState(onError.toString()));
    });
  }
  
  void updateData({
    required String name,
    required String email,
    required String phone,
    String? newtoken,
  }){
    emit(ShopAppLoadingUpdateDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token:newtoken??token ,
        data: {
          'name': name,
          'email': email,
          'phone': phone
        }).then((value) {
      homeUserModel =LoginModel.jsonData(value.data);
      emit(ShopAppSccessUpdateDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopAppErrorUpdateDataState(onError.toString()));
    });
  }
  SearchModel? searchModel ;
  void getSearch({required String text}){
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text': text,
          'token':token
        }
    ).then((value) {
      searchModel = SearchModel.fromjson(value.data);
      emit(SearchSuccesState());
    }).catchError((onError){
      print(onError.toString());
      emit(SearchErrorState());
    });
  }

}