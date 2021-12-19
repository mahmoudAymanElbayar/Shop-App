import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/medules/main_cubit.dart';
import 'package:shop_app/medules/main_states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingModel{
  final String image;
  final String title;
  final String discrib;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.discrib});
}

class OnBoarding extends StatelessWidget{
  List<OnBoardingModel> boardinglist = [
    OnBoardingModel(
        image: 'asset/images/one.png',
        title: 'You can find number 1 here!!!!',
        discrib: 'You can find everything here!!!!'),
    OnBoardingModel(
        image: 'asset/images/two.png',
        title: 'You can find number 2 here!!!!',
        discrib: 'You can find everything here!!!!'),
    OnBoardingModel(
        image: 'asset/images/three.png',
        title: 'You can find number 3 here!!!!',
        discrib: 'You can find everything here!!!!'),
  ];

  OnBoarding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var onBoardingController = PageController();
    // TODO: implement build
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(onPressed: (){
                submit(context:context);
              },
                  child: const Text('skip',
                  style: TextStyle(fontSize: 18.0),
                  ))
            ],
          ),
          body:  Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: onBoardingController,
                  onPageChanged: (index){
                    if(index == boardinglist.length - 1){
                      print('the last');
                      ShopCubit.get(context).goToLoginScreen(last: true);
                    }else{
                      ShopCubit.get(context).goToLoginScreen(last: false);
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>onBoardingItem(boardinglist[index]),
                  itemCount: boardinglist.length,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FloatingActionButton(
                    //   child: Icon(Icons.dark_mode ),
                    //   onPressed: (){
                    //     ShopCubit.get(context).changeMod();
                    //   },
                    // ),
                    SmoothPageIndicator(controller: onBoardingController,
                      count: boardinglist.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defultColor,
                        dotHeight: 10.0,
                        expansionFactor: 4.0,
                        dotWidth: 10.0,
                        spacing: 5.0,
                      ),
                    ),
                    TextButton(
                        child: const Text('NEXT',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),),
                        onPressed: (){
                          bool istrue = ShopCubit.get(context).isLast;
                          if (istrue){
                            submit(context: context);
                          }else{
                            onBoardingController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }

                        },

                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,)
            ],
          )
        );
      },
    );
  }
  Widget onBoardingItem(OnBoardingModel model)=>Container(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(image:AssetImage('${model.image}')),

        const SizedBox(height: 20.0,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text('${model.title}',
            textAlign: TextAlign.center,style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
        ),
        const SizedBox(height: 16,),
        Text('${model.discrib}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold
          ),),

      ],
    ),
  );
}