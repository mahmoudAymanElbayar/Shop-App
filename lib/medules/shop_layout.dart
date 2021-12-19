import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/screens/search_Screen/search_screen.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/shared/component/component.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: cubit.currentIndex != 3 ?AppBar(
            title: const Text('Shop App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1,
                color: Colors.black
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  color: Colors.orange,
                  icon: const Icon(Icons.search),
                  onPressed: (){
                    goTo(context, SearchScreen());
                  },
                ),
              )
            ],
          ) : cubit.appBar(context),
          body: cubit.currentScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            showUnselectedLabels: true,

            onTap: (index){
              cubit.changeBottomNav(index: index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),

        );
      },
      )
    ;
  }
}
