import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) =>
                itemList(ShopAppCubit.get(context).categoriesModel!.data!.data[index]) ,
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
              height: 1,
              color: Colors.grey[300],
              ),
            ),
            itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data.length
        );
      },
    );
  }
  Widget itemList(DataModel dataModel) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        CircleAvatar(child: Image(image: NetworkImage(dataModel.image.toString()),
        fit: BoxFit.cover,
        ),
          radius: 50,
        ),
        const SizedBox(width: 10,),
        Text(dataModel.name.toString(),
          style: const TextStyle(fontSize: 25,
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
