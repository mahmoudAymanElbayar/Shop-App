import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/shop_cubit.dart';
import 'package:shop_app/medules/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/component.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context,state){
        if(state is ShopAppSccessFavouriteDataState){
           if(state.model.status == false){
             toast(message: state.model.message.toString());
           }
        }
      },
        builder: (context,state){
        var cubit = ShopAppCubit.get(context);

        return cubit.homeModel !=null && cubit.categoriesModel != null? Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(items: cubit.homeModel!.data!.banners.map((e) => Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover ,
                  )).toList(),
                    options: CarouselOptions(
                      height: 200,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      scrollDirection: Axis.horizontal
                    )),
                const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Categories',
                        style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index)=> buildCategoryItem(cubit.categoriesModel!.data!.data[index]),
                            separatorBuilder: (context,index)=>const SizedBox(width: 8,),
                            itemCount: cubit.categoriesModel!.data!.data.length)
                      ),
                      const SizedBox(height: 10.0,),
                      const Text('Product',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  //HexColor('#f3b739'),
                  child: GridView.count(crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1/1.38,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                        cubit.homeModel!.data!.products.length,
                            (index) => buildGridProduct(cubit.homeModel!.data!.products[index],context)
                    )
                  ),
                ),
              ],
            ),
          ),
        ):const Center(child: CircularProgressIndicator());
    }

    );
  }
  Widget buildCategoryItem(DataModel dataModel) =>SizedBox(
    height: 100,
    width: 100,
    child: Stack(
      children: [
        Image(image: NetworkImage(dataModel.image.toString()),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          color: Colors.black,
          child: Text(dataModel.name.toString(),
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(

                color: Colors.white,
                fontSize: 16
            ),
          ),
        )
      ],
    ),
  );
  Widget buildGridProduct(ProductsModel productsModel,context) =>Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image(image: NetworkImage(productsModel.image.toString(),),
              height: 200,
              width: double.infinity,
            ),
            if(productsModel.discount != 0)
            Container(
              color: Colors.red,
                child: const Text('discount',style: TextStyle(color: Colors.white),))
          ],
        ),
        Text(
          productsModel.name.toString(),
          maxLines: 2,
            overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            height: 1.2
          ),
        ),
        const Spacer(),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              productsModel.price.round().toString(),

              style: const TextStyle(
                  color: Colors.orange,
                fontSize: 16
              ),
            ),
            const SizedBox(width: 50,),
            if(productsModel.discount != 0)
            Text(
              productsModel.oldPrice.round().toString(),

              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                  color: Colors.grey[400],
                  fontSize: 16
              ),
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
                color: ShopAppCubit.get(context).favouriteMap[productsModel.id] == true ? Colors.orange : Colors.grey[400] ,
                onPressed: (){
                ShopAppCubit.get(context).productFavourite(id:productsModel.id);
                },
                icon: const Icon(Icons.favorite)
            ),
          ],
        ),

      ],
    ),
  );
}
