import 'package:dzshop/models/category_model.dart';
import 'package:dzshop/models/offer_model.dart';
import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin{
  //variables
  int _pageIndex;
  PageController _pageController;
  TabController _tabController;

  //just for testing
  List<CategoryModel> _categories = [
    CategoryModel(1 , 'cat1'),
    CategoryModel(2 , 'cat2'),
    CategoryModel(3 , 'cat3'),
    CategoryModel(4 , 'cat4'),
    CategoryModel(5 , 'cat5'),
    CategoryModel(6 , 'cat6'),
  ];
  List<OfferModel> offers = [
    OfferModel(1, 'offer_title', 'assets/images/offer_back.jpg'),
    OfferModel(3, 'offer_title', 'assets/images/offer_back.jpg'),
    OfferModel(4, 'offer_title', 'assets/images/offer_back.jpg'),
    OfferModel(5, 'offer_title', 'assets/images/offer_back.jpg'),
    OfferModel(6, 'offer_title', 'assets/images/offer_back.jpg'),
    OfferModel(7, 'offer_title', 'assets/images/offer_back.jpg'),
  ];
  List<ProductModel>products = [
    ProductModel(1, 'product_name', 'assets/images/offer_back.jpg', 43.23),
    ProductModel(2, 'product_name', 'assets/images/offer_back.jpg', 43.23),
    ProductModel(3, 'product_name', 'assets/images/offer_back.jpg', 43.23),
    ProductModel(4, 'product_name', 'assets/images/offer_back.jpg', 43.23),
    ProductModel(5, 'product_name', 'assets/images/offer_back.jpg', 43.23),
  ];


  //init state
  @override
  void initState() {
    _pageIndex = 0;
    _pageController = PageController(initialPage: 0);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Découvrir',
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
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
          controller: _tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 24, left: 24),
          labelColor: Colors.grey.shade900,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          unselectedLabelColor: Colors.grey.shade400,
          indicatorColor: Colors.grey.shade400,
          tabs: _drawTabs(_categories),
          onTap: (index) {},
        ),
      ),
      drawer: Drawer(
        child: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
            child: _drawPageView()),
      SizedBox(
          height: 24,
      ),
      Align(
            alignment: Alignment.topLeft,
            child: Text('Nouveau collections',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold))),
      SizedBox(
          height: 24,
      ),
      SizedBox(
            height: 200,
            child: _drawListView(context , products)),
      SizedBox(
          height: 24,
      ),
      Align(
            alignment: Alignment.topLeft,
            child: Text('Best ventes',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold))),
      SizedBox(
          height: 16,
      ),
      SizedBox(
          height: 200,
          child: _drawListView(context , products),
      )
            ],
          ),
        ),
      ),
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
  Widget _drawPageView() {

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
                        image: ExactAssetImage(offers[_pageIndex].image_url),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(offers[_pageIndex].offer_title,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold))),
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
      onPageChanged: (index) {
        setState(() {
          _pageIndex = index;
        });
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
                        image: ExactAssetImage(products[index].image_url),
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
