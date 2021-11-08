import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/shared/components/Components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){

        // var model = ShopCubit.get(context).userModel;
        // nameController.text = model!.data!.name!;
        // emailController.text = model!.data!.email!;
        // phoneController.text = model!.data!.phone!;
        return  Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) => ShopCubit.get(context).userModel != null,
          widgetBuilder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }

                    return null;
                  },
                  label: "Name",
                  prefix: Icons.person,
                ),
                SizedBox(height: 20,),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'email must not be empty';
                    }

                    return null;
                  },
                  label: "Email",
                  prefix: Icons.email,
                ),

                SizedBox(height: 20,),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'phone must not be empty';
                    }

                    return null;
                  },
                  label: "Phone",
                  prefix: Icons.phone,
                ),
                SizedBox(height: 20,),

                defaultButton(
                    function: (){
                      signOut(context);
                      },
                    text: "LogOut"),

              ],
            ),
          ),

          fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
        );
      },
      
    );
  }
}
