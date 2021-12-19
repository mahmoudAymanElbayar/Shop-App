import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/models/search_model.dart';
import '../../shop_cubit.dart';

class SearchScreen extends StatelessWidget {
  var textController = TextEditingController();
  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                      controller: textController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value){
                        ShopAppCubit.get(context).getSearch(text: value.toString());
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'text must be not null';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          prefixIcon: const Icon(Icons.search),
                          label: const Text('type what you need')
                      ),
                    ),
                  ),
                ),
                if(
                       state is SearchSuccesState
                    || state is ShopAppSccessGetFavouriteDataState
                    || state is ShopAppChangeIconDataState
                    || state is ShopAppLoadingGetFavouriteDataState
                    || state is ShopAppSccessFavouriteDataState
                )
                  Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index) =>itemSearchList(ShopAppCubit.get(context).searchModel!.data!.data[index],context),
                        separatorBuilder: (context,index)=>Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount:ShopAppCubit.get(context).searchModel!.data!.data.length
                    ),
                  )
              ],),
          ),
        );
      },
    );
  }
  Widget itemSearchList(ProductData model,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Image(image: NetworkImage(model.image.toString()),
            height: 100,
            width: 100,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( model.name.toString(),
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
                    Text( model.price.round().toString(),

                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(width: 50,),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        color: ShopAppCubit.get(context).favouriteMap[model.id] == true ? Colors.orange : Colors.grey[400] ,
                        onPressed: (){
                          ShopAppCubit.get(context).productFavourite(id:model.id);

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
