import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/models/favourites_screen_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return state != ShopAppLoadingGetFavouriteDataState ?
        ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) =>itemList(ShopAppCubit.get(context).favouriteScreenModel!.data!.data[index],context),
            separatorBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount:ShopAppCubit.get(context).favouriteScreenModel!.data!.data.length
        ) : const Center(child:  CircularProgressIndicator());
      },
    );
  }
  Widget itemList( DataList dataList,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Stack(
            children: [
              Image(image: NetworkImage(dataList.productData!.image.toString()),
                height: 100,
                width: 100,
              ),
              if(dataList.productData!.discount != 0)
                Container(
                    color: Colors.red,
                    child: const Text('discount',style: TextStyle(color: Colors.white),))
            ],
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( dataList.productData!.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.5
                  ),
                ),
                const Spacer(),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text( dataList.productData!.price.toString(),

                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(width: 50,),
                    if(dataList.productData!.discount != 0)
                      Text(
                        dataList.productData!.old_price.toString(),

                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[400],
                            fontSize: 16
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        color: ShopAppCubit.get(context).favouriteMap[dataList.productData!.id] == true ? Colors.orange : Colors.grey[400] ,
                        onPressed: (){
                            ShopAppCubit.get(context).productFavourite(id:dataList.productData!.id);
                        },
                        icon: const Icon(Icons.favorite)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
