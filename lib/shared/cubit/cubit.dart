import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/categories/CategoriesScreen.dart';
import 'package:shop_app/layouts/favourites/FavoritiesScreen.dart';
import 'package:shop_app/layouts/products/productScreen.dart';
import 'package:shop_app/layouts/settings/settingsScreen.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/favourities/change_favourite_model.dart';
import 'package:shop_app/models/favourities/favorite_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/networks/end_point.dart';
import 'package:shop_app/shared/networks/remote/DioHelper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());



  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritiesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image!);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      print(favorites.toString());
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
       }
        else {
        getFavorites();
      }

      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ShopChangeFavoritesErrorState());
    });
  }


  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }

  LoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
       printFullText(value.data);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

}
