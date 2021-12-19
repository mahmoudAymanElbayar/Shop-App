import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/login_screen.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/shared/component/component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
      },
      builder: (context,state){
          var model = ShopAppCubit.get(context).homeUserModel;
        return Scaffold(
          body: state is ShopAppLoadingProfileState? const CircularProgressIndicator(): Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              CircleAvatar(
                child: Image(
                  image: NetworkImage(model!.data!.image.toString()),
                  fit: BoxFit.cover,
                ),
                radius: 50,
              ),
              const SizedBox(height: 16,),
              PhysicalModel(
                elevation: 8,
                color: Colors.white,
                shadowColor: Colors.white54,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(child: Text('user name',style: TextStyle(color: Colors.grey),)),
                      Text(model.data!.name.toString())
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              PhysicalModel(
                elevation: 8,
                color: Colors.white,
                shadowColor: Colors.white54,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(child: Text('email',style: TextStyle(color: Colors.grey),)),
                      Text(model.data!.email.toString())
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              PhysicalModel(
                elevation: 8,
                color: Colors.white,
                shadowColor: Colors.white54,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      const Expanded(child: Text('phone',style: TextStyle(color: Colors.grey),)),
                      Text(model.data!.phone.toString())
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              PhysicalModel(
                color: HexColor('#f3b739'),
                elevation: 8,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: (){
                    ShopAppCubit.get(context).currentIndex=0;
                    CacheHelper.removeDAta(key: 'token');
                    goAndFinish(context, LoginScreen());
                  },
                  child: const Text('Logout'),
                ),
              )

            ],),
          ),
        );
      },
    );
  }
}
