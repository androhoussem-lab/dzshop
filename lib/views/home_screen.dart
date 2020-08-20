import 'package:dzshop/models/category_model.dart';
import 'package:dzshop/models/offer_model.dart';
import 'package:dzshop/models/product_model.dart';
import 'package:dzshop/providers/category_provider.dart';
import 'package:dzshop/providers/home_provider.dart';
import 'package:dzshop/util/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //parameters
  TabController _tabController;
  PageController _pageController;
  int _categoryId = 1;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 1);
    _fetchCategories(context);
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<CategoryProvider>(context, listen: false).dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _fetchHomeScreen(_categoryId);
    return _drawHomeScreen(_categoryId);
  }

  Widget _drawCircularProgress() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  //this section for drawing the vue
  ////////////////////////////////////
  Widget _drawAppBar(BuildContext context) {
    return AppBar(
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
      bottom: _drawTabBar(context),
    );
  }

  Widget _drawTabBar(BuildContext context) {
    List<CategoryModel> categories =
        Provider.of<CategoryProvider>(context).getCategories();
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelPadding: EdgeInsets.only(right: 24, left: 24),
      labelColor: Colors.grey.shade900,
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      unselectedLabelColor: Colors.grey.shade400,
      indicatorColor: Colors.grey.shade400,
      tabs: _drawTabs(categories),
      onTap: (index) {
        Provider.of<CategoryProvider>(context, listen: false)
            .setCategoryId(index);
        Provider.of<HomeProvider>(context, listen: false).setLoading(true);
        _categoryId = Provider.of<CategoryProvider>(context, listen: false)
            .getCategoryId();
      },
    );
  }

  Widget _drawPageView() {
    List<OfferModel> offers = Provider.of<HomeProvider>(context, listen: false)
        .getHomeModel()
        .category_offers;
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
                        image: NetworkImage(offers[_pageIndex].image_url),
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

  List<Tab> _drawTabs(List<CategoryModel> categories) {
    List<Tab> tabs = [];
    for (var category in categories) {
      tabs.add(Tab(text: category.category_name));
    }
    return tabs;
  }

  Widget _drawHomeScreen(int categoryId) {
    return (Provider.of<CategoryProvider>(context).loading == false)
        ? Scaffold(
            appBar: _drawAppBar(context),
            drawer: Drawer(
              child: Container(),
            ),
            body: (Provider.of<HomeProvider>(context).getLoading() == false)
                ? SingleChildScrollView(
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
                            child: _drawListView(
                                context,
                                Provider.of<HomeProvider>(context)
                                    .getHomeModel()
                                    .category_products),
                          ),
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
                            child: _drawListView(
                                context,
                                Provider.of<HomeProvider>(context)
                                    .getHomeModel()
                                    .category_products),
                          )
                        ],
                      ),
                    ),
                  )
                : _drawCircularProgress(),
          )
        : _drawCircularProgress();
  }

  //this section for fetching the data
  ////////////////////////////////////

  _fetchCategories(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories()
        .then((data) {
      if (data != null) {
        Provider.of<CategoryProvider>(context, listen: false)
            .setCategories(data);
        _tabController = TabController(
            length: Provider.of<CategoryProvider>(context, listen: false)
                .getCategoriesLength(),
            vsync: this);
        Provider.of<CategoryProvider>(context, listen: false).setCategoryId(0);
      }
    }).catchError((error) {
      showAlert(
          context: context,
          title: 'Erreur dans l\'opération',
          content: error.toString());
    });
  }

  _fetchHomeScreen(int categoryId) {
    Provider.of<HomeProvider>(context, listen: false)
        .fetchHome(categoryId)
        .then((data) {
      if (data != null) {
        Provider.of<HomeProvider>(context, listen: false).setHomeModel(data);
        Provider.of<CategoryProvider>(context, listen: false)
            .setCategoryId(_categoryId);
        Provider.of<HomeProvider>(context, listen: false).setLoading(false);
      }
    }).catchError((error) {
      showAlert(
          context: context,
          title: 'Erreur dans l\'opération',
          content: error.toString());
    });
  }
}
