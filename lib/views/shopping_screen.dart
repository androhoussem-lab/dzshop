import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/providers/wishlist_provider.dart';
import 'package:dzshop/util/custom_theme.dart';
import 'package:dzshop/views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ShoppingScreen extends StatefulWidget {
  final List<ProductModel> products;

  ShoppingScreen(this.products);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Shopping',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontFamily: 'BreeSerif'),
        ),
      ),
      drawer: Drawer(
        child: Container(),
      ),
      body: GridView.builder(
        addAutomaticKeepAlives: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(widget.products[index].product_id, widget.products[index].isFavorite)));
                },
                child: Stack(
                  children: [
                    Container(
                      child: Padding(
                        padding:  EdgeInsets.zero,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  widget.products[index].image_url,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: Text('Chargement...'),
                                    );
                                  },

                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.products[index].product_name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.products[index].product_price.toString() + ' DA',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  (widget.products[index].product_discount == 0.00)
                                      ? SizedBox()
                                      : Text(
                                    widget.products[index].product_discount.toString() +
                                        '%',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top:8.0 , right: 16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Consumer<WishListProvider>(
                          builder: (context, wishList, child) {
                            return IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.solidHeart,
                                  color:(! widget.products[index].isFavorite)? Colors.white:CustomTheme.CUSTOM_THEME.primaryColor,
                                ),
                                onPressed: () {
                                  wishList.addToWishList(widget.products[index]);
                                  print(wishList.wishList);
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
