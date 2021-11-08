import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/layouts/home/HomeScreen.dart';
import 'package:shop_app/layouts/login/cubit/Cubit.dart';
import 'package:shop_app/layouts/login/cubit/States.dart';
import 'package:shop_app/layouts/register/RegisterScreen.dart';
import 'package:shop_app/shared/components/Components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/networks/local/cash_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, Object? state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel!.status!){
              print(state.loginModel!.message);
              print(state.loginModel!.data!.token);
              CacheHelper.saveData(
                  key: 'token',
                  value:state.loginModel!.data!.token,
              ).then((value) {
                token = state.loginModel!.data!.token!;
                  navigateAndFinish(context, HomeScreen()
                  );
            });
            }else{
              print(state.loginModel!.message);
              showToast(text: state.loginModel!.message!,state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          "login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(height: 40.0),
                        defaultFormField(
                            controller: emailController,
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ("email adress must not be empty");
                              }
                              return null;
                            }),
                        SizedBox(height: 20.0),
                        defaultFormField(
                            controller: passwordController,
                            label: "Password",
                            prefix: Icons.lock_open_outlined,
                            suffix: ShopLoginCubit.get(context).suffix,
                            onSubmit: (value){
                              if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }},
                            isPassword: ShopLoginCubit.get(context).isPassword,

                            suffixPressed: () {
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return ("password must not be empty");
                              }
                              return null;
                            }),
                        SizedBox(height: 20.0),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) => state is! ShopLoginLoadingState,
                          widgetBuilder: (BuildContext context) => defaultButton(
                              text: 'login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                          fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account"),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: "Register"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
