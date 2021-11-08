import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/models/favourities/favorite_model.dart';
import 'package:shop_app/shared/components/Components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritiesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Conditional.single(
          context: context,
            conditionBuilder: (BuildContext context) => state is! ShopLoadingGetFavoritesState,
            widgetBuilder: (BuildContext context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data!.data![index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
        ),
        fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
 Widget buildFavItem(FavoritesData model, context) => Padding(
   padding: const EdgeInsets.all(20.0),
   child: Container(
     height: 120.0,

     child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Stack(
           // alignment: AlignmentDirectional.bottomStart,
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                 child: Image(
                   image: NetworkImage(model.product!.image!),
                   width: 120.0,
                   height: 120.0,
                 ),
               ),
               if (model.product!.discount! != 0)
                 Container(
                   color: Colors.red,
                   padding: EdgeInsets.symmetric(horizontal: 5.0),
                   child: Text(
                     'DISCOUNT',
                     style: TextStyle(
                       fontSize: 8.0,
                       color: Colors.white,
                     ),
                   ),
                 )
             ]),
         SizedBox(width:20.0),
         Expanded(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 model.product!.name!,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(height: 1.3),
               ),
               Spacer(),
               Row(
                 children: [
                   Text(
                     model.product!.price!.toString(),
                     style: TextStyle(
                       fontSize: 12.0,
                       height: 1.3,
                       color: defaultColor,
                     ),
                   ),
                   SizedBox(
                     width: 5.0,
                   ),
                   if (model.product!.discount! != 0)
                     Text(
                       model.product!.oldPrice!.toString(),
                       style: TextStyle(
                           fontSize: 10.0,
                           height: 1.3,
                           color: Colors.grey,
                           decoration: TextDecoration.lineThrough),
                     ),
                   Spacer(),
                   IconButton(
                     onPressed: () {
                       ShopCubit.get(context).changeFavorites(model.product!.id!);
                       // print(model.id);
                     },
                     icon: CircleAvatar(
                         radius: 14.0,
                         backgroundColor:
                         ShopCubit.get(context).favorites[model.product!.id]!
                             ? defaultColor
                             : Colors.grey,
                         child: Icon(
                           Icons.favorite_border,
                           color:Colors.white,
                           size: 14.0,
                         )
                     ),
                   )
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
