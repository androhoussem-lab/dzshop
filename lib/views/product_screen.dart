import 'package:dzshop/api/product_resource.dart';
import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/providers/color_provider.dart';
import 'package:dzshop/providers/size_provider.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final int _productId;
  final bool _isFavorite;

  ProductScreen(this._productId , this._isFavorite);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetails>(
          future: fetchProductDetails(widget._productId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                showAlert(
                    context: context,
                    title: 'Connection',
                    content: 'Erreur dans la connextion');
                break;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.data != null) {
                  //_size = snapshot.data.optionSizes[0];
                  //_color = snapshot.data.optionColors[0];
                  return Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: drawPageView(
                                  context, snapshot.data.image_url),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot.data.product_price.toString() +
                                            " DA",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(45)),
                                        elevation: 2,
                                        clipBehavior: Clip.antiAlias,
                                        child: IconButton(
                                            icon: (widget._isFavorite)?Icon(
                                              FontAwesomeIcons.solidHeart,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ):Icon(FontAwesomeIcons.heart , color: Theme.of(context).primaryColor,),
                                            onPressed: () {}),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Nike',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.data.product_name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  _drawStars(4),
                                  //draw options
                                  _drawOptions(
                                      context, snapshot.data.optionColors , snapshot.data.optionSizes),
                                  Text(
                                    'Description de produit',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshot.data.description,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: ButtonStyle(
                            context: context,
                            child: Text(
                              'Ajouter au sac',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  showAlert(
                      context: context,
                      title: 'Connection',
                      content: 'Les donnée est vide!!');
                }
                break;
            }
            return Container();
          }),
    );
  }

  Widget drawPageView(BuildContext context, List<String> images) {
    return PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _drawStars(int stars) {
    List<Widget> starsList = [];
    int totalStars = 5;
    int restStars = totalStars - stars;
    for (int i = 0; i < stars; i++) {
      starsList.add(Icon(
        Icons.star,
        color: Theme.of(context).primaryColor,
      ));
    }
    for (int i = 0; i < restStars; i++) {
      starsList.add(Icon(
        Icons.star_border,
        color: Theme.of(context).primaryColor,
      ));
    }
    return Row(
      children: starsList,
    );
  }

  Widget _drawOptions(BuildContext context, List<dynamic> colors , List<dynamic> sizes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                'Couleurs',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                children: _drawColorsList(colors),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                'Tailles',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Row(
                children: _drawSizesList(sizes),
              ),
            )
          ],
        ),
      ],
    );
  }

  List<Widget> _drawColorsList(List<dynamic> colors) {
    List<Widget> colorsContainers = [];
    for (var color in colors) {
      switch (color) {
        case 'black':
          colorsContainers.add(_drawCircularColor(Colors.black));
          break;
        case 'white':
          colorsContainers.add(_drawCircularColor(Colors.white70));
          break;
        case 'yellow':
          colorsContainers.add(_drawCircularColor(Colors.yellow));
          break;
        case 'green':
          colorsContainers.add(_drawCircularColor(Colors.green));
          break;
        case 'purple':
          colorsContainers.add(_drawCircularColor(Colors.purple));
          break;
        case 'pink':
          colorsContainers.add(_drawCircularColor(Colors.pink));
          break;
        default:
          colorsContainers.add(_drawCircularColor(Colors.black));
          break;
      }
    }
    return colorsContainers;
  }
  List<Widget> _drawSizesList(List<dynamic> sizes) {
    List<Widget> sizesList=[];
    for(var size in sizes){
      sizesList.add(_drawCircularSizes(size));
    }
    return sizesList;
  }
//TODO:You must make states management with provider
  Widget _drawCircularColor(Color color) {
    return Padding(
      padding: EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: (){
          Provider.of<ColorProvider>(context , listen: false).setColor(color);
        },
        child: Consumer<ColorProvider>(
          builder: (context,colorProvider,child){
            return Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle,border: Border.all(width: 2 , color: (color == colorProvider.color)?Theme.of(context).primaryColor:Colors.white)),
            );
          },
        ),
      ),
    );
  }
//TODO:You must make states management with provider
  Widget _drawCircularSizes(String size) {
    return Padding(
      padding: EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: (){
          Provider.of<SizeProvider>(context , listen: false).setSize(size);
        },
        child: Consumer<SizeProvider>(
          builder: (context , sizeProvider , child){
            return Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: (sizeProvider.size == size)?Theme.of(context).primaryColor:Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(size , style: TextStyle(fontSize: 16 , color: (sizeProvider.size == size)?Colors.white:Colors.black), )),
            );
          },
        ),
      ),
    );
  }
}
