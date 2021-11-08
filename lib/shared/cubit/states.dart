import 'package:shop_app/models/favourities/change_favourite_model.dart';
import 'package:shop_app/models/login/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}
class ShopHomeSuccessState extends ShopStates{}
class ShopHomeErrorState extends ShopStates{
  final error;
  ShopHomeErrorState({this.error});

}
class ShopCategoriesSuccessState extends ShopStates{}
class ShopCategoriesErrorState extends ShopStates{
  final error;
  ShopCategoriesErrorState({this.error});

}
class ShopChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesSuccessState extends ShopStates{

  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}
class ShopChangeFavoritesErrorState extends ShopStates{
  final error;
  ShopChangeFavoritesErrorState({this.error});

}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopGetFavoritesSuccessState extends ShopStates{}
class ShopGetFavoritesErrorState extends ShopStates{
  final error;
  ShopGetFavoritesErrorState({this.error});

}

class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final LoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{
  final error;
  ShopErrorUserDataState({this.error});

}




