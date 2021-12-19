import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/main_cubit.dart';
import 'package:shop_app/medules/main_states.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_layout.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSccessRegisterDataState) {
          if (state.register.status!) {
            toast(
                message: state.register.message.toString(),
                backColor: const Color(0xFFF3b739),
                textColor: Colors.white);
            CacheHelper.putAllDAta(
                key: 'token', value: state.register.data!.token)
                .then((value) {
              token = state.register.data!.token.toString();
              ShopAppCubit.get(context).getNewData(newtoken: token);
              goAndFinish(context, const ShopLayout());
            });
          } else {
            toast(message: state.register.message.toString());
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#f3b739'),
            ),
            backgroundColor: HexColor('#f3b739'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        const Image(
                          image:
                          AssetImage('asset/images/white_cueve_bg.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    const Text(
                                      'Register Now',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    PhysicalModel(
                                      color: Colors.white,
                                      shadowColor: Colors.white54,
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'name must be not null';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(25)
                                          ),
                                          prefixIcon: const Icon(Icons.person),
                                          label: const Text('your name')
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    PhysicalModel(
                                      color: Colors.white,
                                      shadowColor: Colors.white54,
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'email must be not null';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                            prefixIcon: const Icon(Icons.mail),
                                            label: const Text('your email')
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    PhysicalModel(
                                      color: Colors.white,
                                      shadowColor: Colors.white54,
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        controller: passController,
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'password must be not null';
                                          }
                                        },
                                        obscureText: ShopCubit.get(context).isVisible,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                            prefixIcon: const Icon(Icons.lock),
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  ShopCubit.get(context)
                                                      .showPassword();
                                                },
                                                icon: ShopCubit.get(context)
                                                    .isVisible
                                                    ? const Icon(
                                                    Icons.visibility_outlined)
                                                    : const Icon(Icons.visibility_off)),
                                            label: const Text('your password')
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    PhysicalModel(
                                      color: Colors.white,
                                      shadowColor: Colors.white54,
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(25),
                                      child: TextFormField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        validator: (value){
                                          if(value!.isEmpty){
                                            return 'phone must be not null';
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(25)
                                            ),
                                            prefixIcon: const Icon(Icons.phone),
                                            label: const Text('your phone')
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  child: state is! ShopLoadingRegisterDataState
                                      ? IconButton(
                                      onPressed: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                          ShopCubit.get(context).register(
                                              email: emailController
                                                  .text,

                                              password: passController
                                                  .text,
                                              name: nameController.text,
                                              phone:phoneController.text);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 40,
                                      ))
                                      : const CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
