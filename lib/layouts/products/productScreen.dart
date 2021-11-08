import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/shared/components/Components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if(state is ShopChangeFavoritesSuccessState){
          if(!state.model.status!){
            showToast(
                text: state.model.message!,
                state: ToastStates.ERROR
            );
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
              ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          widgetBuilder: (BuildContext context) => productsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,context),
          fallbackBuilder: (BuildContext context) =>
              Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model.data!.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 250.0,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1))),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      buildCategoryItem(categoriesModel.data!.data![index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10.0,
                      ),
                  itemCount: categoriesModel.data!.data!.length),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "New Products",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
            ),
            GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 1 / 1.3,
                children: List.generate(model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context))),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              model.image!,
            ),
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100.0,
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  Widget buildGridProduct(ProductModel model,context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              // alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image(
                    image: NetworkImage(model.image!),
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
                if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      "${model.price!.round()}",
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.3,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.oldPrice!.round()}",
                        style: TextStyle(
                            fontSize: 10.0,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                          // print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 14.0,
                            backgroundColor:
                            ShopCubit.get(context).favorites[model.id]!
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
      );
}
