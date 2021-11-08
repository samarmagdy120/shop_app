import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home/HomeScreen.dart';
import 'package:shop_app/layouts/login/LoginScreen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/bloc_observer.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/networks/local/cash_helper.dart';
import 'package:shop_app/shared/networks/remote/DioHelper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layouts/onboarding/OnBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
   token = CacheHelper.getData(key: 'token');

  if(onBoarding != null){
    if(token != null) widget = HomeScreen();
    else widget = LoginScreen();
  }else widget = OnBoardingScreen();
  // print(onBoarding);
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(starWidget: widget,));
}

class MyApp extends StatelessWidget {
  //3lshan bna 3lih hft7 3la onBoarding or login
  final Widget? starWidget;
  MyApp({this.starWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: starWidget,
          );
        },

      ),
    );
  }
}
