import 'package:dzshop/api/home_resource.dart';
import 'package:dzshop/models/category_model.dart';
import 'package:dzshop/models/home_model.dart';
import 'package:dzshop/models/offer_model.dart';
import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/providers/category_provider.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //variables
  PageController _pageController;
  TabController _tabController;

  void fetchCatgories() {
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories()
        .then((value) {
      if (value.length > 0) {
        Provider.of<CategoryProvider>(context, listen: false)
            .setCategories(value);
        Provider.of<CategoryProvider>(context, listen: false).setCategoryId(0);
      }
    }).catchError((error) {});
  }

  //init state
  @override
  void initState() {
    fetchCatgories();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85);
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Selector<CategoryProvider, List<CategoryModel>>(
      selector: (context, categoryProvider) => categoryProvider.getCategories(),
      builder: (context, categories, child) {
        if (categories == null || categories.isEmpty) {
          return drawCircularProgress();
        } else {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                title: Text(
                  'Découvrir',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 24),
                ),
                actions: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey.shade700,
                        size: 30,
                      ),
                      onPressed: () {}),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.grey.shade700,
                          size: 30,
                        ),
                        onPressed: () {}),
                  ),
                ],
                bottom: TabBar(
                  controller:
                      TabController(length: categories.length, vsync: this),
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 24, left: 24),
                  labelColor: Colors.grey.shade900,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  unselectedLabelColor: Colors.grey.shade400,
                  indicatorColor: Colors.grey.shade400,
                  tabs: _drawTabs(categories),
                  onTap: (index) {
                    Provider.of<CategoryProvider>(context, listen: false)
                        .setCategoryId(index);
                  },
                ),
              ),
              drawer: Drawer(
                child: Container(),
              ),
              body: Selector<CategoryProvider, int>(
                  selector: (context, categoryId) => categoryId.getCategoryId(),
                  builder: (context, categoryId, child) {
                    print('Rebuild');
                    return FutureBuilder<HomeModel>(
                      future: fetchHome(categoryId),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text(snapshot.connectionState.toString());
                            break;
                          case ConnectionState.waiting:
                            return drawCircularProgress();
                            break;
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.data == null || !snapshot.hasData) {
                              return Text('Data List is empty ',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ));
                            } else {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          child: _drawPageView(
                                              snapshot.data.category_offers)),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Nouveau collections',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      SizedBox(
                                          height: 200,
                                          child: _drawListView(context,
                                              snapshot.data.category_products)),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Text('Best ventes',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontSize: 24,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      SizedBox(
                                        height: 200,
                                        child: _drawListView(context,
                                            snapshot.data.category_products),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            break;
                          default:
                            return Container();
                        }
                      },
                    );
                  }));
        }
      },
    );
  }

  //draw tabs by list
  List<Tab> _drawTabs(List<CategoryModel> categories) {
    List<Tab> tabs = [];
    for (var category in categories) {
      tabs.add(Tab(text: category.category_name));
    }
    return tabs;
  }

  //draw page view for offers
  Widget _drawPageView(List<OfferModel> offers) {
    return PageView.builder(
      controller: _pageController,
      itemCount: offers.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          elevation: 5,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(offers[index].image_url),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                         child: Align(
                         alignment: Alignment.topLeft,
                         child: Text(offers[index].offer_title,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Shop now',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //draw List View for Products
  Widget _drawListView(BuildContext context, List<ProductModel> products) {
    return ListView.builder(
        itemCount: products.length,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Image(
                        image: NetworkImage(products[index].image_url),
                        fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 16),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        products[index].product_name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      products[index].product_price.toString() + ' DA',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      '30 %',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
