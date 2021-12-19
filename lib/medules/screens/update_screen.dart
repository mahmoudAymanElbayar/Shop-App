import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';

class UpdateScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  UpdateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if (state is ShopAppSccessUpdateDataState){
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        var model = ShopAppCubit.get(context).homeUserModel;
        nameController.text=model!.data!.name.toString();
        emailController.text=model.data!.email.toString();
        phoneController.text=model.data!.phone.toString();
        return Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: const Text('Update',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1,
                color: Colors.black
            ), ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: (){
                    ShopAppCubit.get(context).updateData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
                  },
                  icon:const Icon(Icons.done_outlined,size: 30,color: Colors.orange,))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(state is ShopAppLoadingUpdateDataState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                CircleAvatar(
                  child: Image(
                    image: NetworkImage(model.data!.image.toString()),
                    fit: BoxFit.cover,
                  ),
                  radius: 50,
                ),
                  const SizedBox(height: 30,),
                PhysicalModel(
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                   // padding: EdgeInsets.symmetric(horizontal: 28),
                    width: double.infinity,
                    height: 50,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value){
                        nameController.text=value.toString();
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'name must be not null';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          prefixIcon: const Icon(Icons.person),
                          label: const Text('your name')
                      ),
                    ),
                  ),
                ),
                  const SizedBox(height: 30,),
                  PhysicalModel(
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      // padding: EdgeInsets.symmetric(horizontal: 28),
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        onChanged: (value){
                          emailController.text=value.toString();
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'email must be not null';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            prefixIcon: const Icon(Icons.mail),
                            label: const Text('your name')
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  PhysicalModel(
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      // padding: EdgeInsets.symmetric(horizontal: 28),
                      width: double.infinity,
                      height: 50,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.text,
                        onChanged: (value){
                          phoneController.text=value.toString();
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'phone must be not null';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            prefixIcon: const Icon(Icons.phone),
                            label: const Text('your name')
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),


              ],),
            ),
          ),
        );
      },
    );
  }
}
