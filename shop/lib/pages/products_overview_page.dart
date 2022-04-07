// import 'package:shop/data/dummy_data.dart';
// import 'package:provider/provider.dart';
// import 'package:shop/components/product_item.dart';
// import 'package:shop/models/product.dart';
// import 'package:shop/models/product_list.dart';
// import 'package:shop/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { Favorite, All }

class ProductsOverwiewPage extends StatefulWidget {
  ProductsOverwiewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverwiewPage> createState() => _ProductsOverwiewPageState();
}

class _ProductsOverwiewPageState extends State<ProductsOverwiewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductList>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              //os tres pontinhos
              PopupMenuItem(
                child: Text("Somente Favoritos"),
                value: FilterOptions.Favorite,
              ),
              //os tres pontinhos
              PopupMenuItem(
                child: Text("Todos"),
                value: FilterOptions.All,
              ),
            ],
            // onSelected: (FilterOptions selectedValue) {
            // print(selectedValue);
            // if (selectedValue == FilterOptions.Favorite) {
            //   provider.showFavoriteOnly();
            // } else {
            //   provider.showAll();
            // }
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
