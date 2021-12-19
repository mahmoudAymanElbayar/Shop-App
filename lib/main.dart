import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/bloc_observer.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/dio_helper.dart';
import 'package:shop_app/medules/login_screen.dart';
import 'package:shop_app/medules/main_cubit.dart';
import 'package:shop_app/medules/main_states.dart';
import 'package:shop_app/medules/my_http.dart';
import 'package:shop_app/medules/onboard_screen.dart';
import 'package:shop_app/medules/shop_layout.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'shared/component/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  var isDark = CacheHelper.getData(key: 'isDark') ?? false;
  var onBoarding = CacheHelper.getAllDAta(key: 'onBoarding') ?? false;
  token = CacheHelper.getAllDAta(key:'token');
  Widget widget;
  if (onBoarding) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      print('mahmoud$token');
      widget = LoginScreen();
    }
  } else {
    widget = OnBoarding();
  }
  runApp(MyApp(
    isDark: isDark,
    firstScreen: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget firstScreen;

  const MyApp({required this.isDark, required this.firstScreen});

  //const MyApp( {Key? key,bool? isDark) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) =>
    ShopCubit()..changeMod(fromshared: isDark)),
    BlocProvider(create:(BuildContext context)=>
    ShopAppCubit()..homeScreen()..getCategories()..getFavourite()..getProfile()),],
          child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: defultColor,
                  appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      elevation: 0.0,
                      titleTextStyle: TextStyle(fontSize: 16.0)),
                  scaffoldBackgroundColor: Colors.white,
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white,
                    selectedItemColor:Colors.orangeAccent,
                    unselectedItemColor: Colors.grey,

                  )
                ),
                darkTheme: ThemeData(
                  scaffoldBackgroundColor: Colors.black,
                ),
                themeMode: ShopCubit.get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: firstScreen,
              );
            },
          ),
    );
  }
}
