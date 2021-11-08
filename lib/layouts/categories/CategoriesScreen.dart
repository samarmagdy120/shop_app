import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/shared/components/Components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoriesSection(ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length
        );
      },

    );
  }

  Widget buildCategoriesSection(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image!,),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(model.name!,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
