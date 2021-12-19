import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/main_cubit.dart';
import 'package:shop_app/medules/main_states.dart';
import 'package:shop_app/medules/screens/register_screen/register_screen.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_layout.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSccessDataState) {
          if (state.loginModel.status!) {
              toast(
                  message: state.loginModel.message
                      .toString(),
                  backColor: const Color(0xFFF3b739),
                  textColor: Colors.white);
              CacheHelper.putAllDAta(
                  key: 'token',
                  value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token.toString();
                ShopAppCubit.get(context).getNewData(newtoken: token);
                goAndFinish(
                    context, const ShopLayout());

              });
            } else {
              toast(message: state.loginModel.message.toString());
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
                    padding: const EdgeInsets.all(20.0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      child: defultEditText(
                                          controller: emailController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'email must be not empty';
                                            }
                                            return null;
                                          },
                                          lable: 'email',
                                          prefixIcon: Icons.mail),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      child: defultEditText(
                                        controller: passController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'passward must be not empty';
                                          }
                                          return null;
                                        },
                                        lable: 'passward',
                                        prefixIcon: Icons.lock,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              ShopCubit.get(context)
                                                  .showPassword();
                                            },
                                            icon: ShopCubit
                                                .get(context)
                                                .isVisible
                                                ? const Icon(
                                                Icons.visibility_outlined)
                                                : const Icon(Icons.visibility_off)),
                                        keyboardType:
                                        TextInputType.visiblePassword,
                                        obscureText:
                                        ShopCubit
                                            .get(context)
                                            .isVisible,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                Container(
                                  child: state is! ShopLoadingDataState
                                      ? IconButton(
                                      onPressed: () {
                                        if (formKey.currentState!
                                            .validate()) {
                                          ShopCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passController.text);

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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('don\'t have an account? ', style: TextStyle(
                        fontSize: 16,
                        //color: Colors.white
                      ),),
                      TextButton(onPressed: () {
                        goTo(context, RegisterScreen());
                      },
                          child: const Text('Register', style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              decoration: TextDecoration.underline
                          ),))
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
