import 'package:shop_app/models/favourite_model.dart';
import 'package:shop_app/models/user_model.dart';

abstract class ShopAppStates{}
class InitShopState extends ShopAppStates{}
class ChangeBottomNavtShopState extends ShopAppStates{}

class ShopAppLoadingDataState extends ShopAppStates{}
class ShopAppSccessDataState extends ShopAppStates{
  // final LoginModel loginModel;
  // ShopAppSccessDataState(this.loginModel);
}
class ShopAppErrorDataState extends ShopAppStates{
  final String error;
  ShopAppErrorDataState(this.error);
}

class ShopAppSccessCategoriesDataState extends ShopAppStates{}
class ShopAppErrorCategoriesDataState extends ShopAppStates{
  final String error;
  ShopAppErrorCategoriesDataState(this.error);
}

class ShopAppSccessFavouriteDataState extends ShopAppStates{
  final FavouriteModel model;

  ShopAppSccessFavouriteDataState(this.model);
}
class ShopAppChangeIconDataState extends ShopAppStates{}
class ShopAppErroFavouriteDataState extends ShopAppStates{
  final String error;
  ShopAppErroFavouriteDataState(this.error);
}

class ShopAppLoadingGetFavouriteDataState extends ShopAppStates{}
class ShopAppSccessGetFavouriteDataState extends ShopAppStates{}
class ShopAppErrorGetFavouriteDataState extends ShopAppStates{
  final String error;
  ShopAppErrorGetFavouriteDataState(this.error);
}

class ShopAppLoadingProfileState extends ShopAppStates{}
class ShopAppGetUserDataState extends ShopAppStates{
  final UserData userData;

  ShopAppGetUserDataState(this.userData);
}
class ShopAppErrorGetUserDataState extends ShopAppStates{
  final String error;
  ShopAppErrorGetUserDataState(this.error);
}


class ShopAppLoadingUpdateDataState extends ShopAppStates{}
class ShopAppSccessUpdateDataState extends ShopAppStates{}
class ShopAppErrorUpdateDataState extends ShopAppStates{
  final String error;
  ShopAppErrorUpdateDataState(this.error);
}

class SearchSuccesState extends ShopAppStates{}
class SearchErrorState extends ShopAppStates{}