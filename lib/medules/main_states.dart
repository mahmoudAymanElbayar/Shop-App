import 'package:shop_app/models/user_model.dart';

abstract class ShopStates{}
class InitState extends ShopStates{}
class ChangeModState extends ShopStates{}
class ChangeBoardingState extends ShopStates{}

class ShopLoadingDataState extends ShopStates{}
class ShopSccessDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSccessDataState(this.loginModel);
}
class ShopErrorDataState extends ShopStates{
  final String error;
  ShopErrorDataState(this.error);
}

class ShowPasswordState extends ShopStates{}

class ShopLoadingRegisterDataState extends ShopStates{}
class ShopSccessRegisterDataState extends ShopStates{
  final LoginModel register;
  ShopSccessRegisterDataState(this.register);
}
class ShopErrorRegisterDataState extends ShopStates{
  final String error;
  ShopErrorRegisterDataState(this.error);
}


