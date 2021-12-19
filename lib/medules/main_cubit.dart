import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/dio_helper.dart';
import 'package:shop_app/medules/main_states.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/end_point/end_point.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super (InitState());
  static ShopCubit get (context)=>BlocProvider.of(context);
  LoginModel? loginModel;
  bool isDark = false;
  void changeMod({bool? fromshared}){
    if(fromshared != null){
      isDark = fromshared ;
      emit(ChangeModState());
    }else{
      isDark =! isDark;
      CacheHelper.putAllDAta(key: 'isDark', value: isDark);
      emit(ChangeModState());

    }
    }
    bool isLast=false;
  void goToLoginScreen({required bool last}){
    isLast = last;
    emit(ChangeBoardingState());
  }

  void userLogin({
    required String email,
    required String password,
}){
    emit(ShopLoadingDataState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      loginModel = LoginModel.jsonData(value.data);
      emit(ShopSccessDataState(loginModel!));
    }).catchError((onError){
      print('the errrrrrroorooor${onError.toString()}');
    });
  }
  bool isVisible= true;
  void showPassword(){
    isVisible =! isVisible ;
    emit(ShowPasswordState());
  }

   LoginModel? registerModel;
  void register({
  required String email,
    required String password,
    required String name ,
    required String phone,
}){
    emit(ShopLoadingRegisterDataState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone
        }).then((value) {
      registerModel = LoginModel.jsonData(value.data);
      emit(ShopSccessRegisterDataState(registerModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorRegisterDataState(onError.toString()));
    });

  }
}