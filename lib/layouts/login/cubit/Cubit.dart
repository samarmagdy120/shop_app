import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/login/cubit/States.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/shared/networks/end_point.dart';
import 'package:shop_app/shared/networks/remote/DioHelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  //take object mny to use sny place
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password
  }) {

    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data:
        {
          'email': email,
          'password': password
        }
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson((value.data));
      // print(loginModel!.status);
      //
      // print(loginModel!.message);
      // print(loginModel!.data!.token);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
bool isPassword =true;
  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
