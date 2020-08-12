import 'package:dzshop/models/on_boarding.dart';
import 'package:dzshop/util/screen_configuration.dart';
import 'package:dzshop/views/register_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  ScreenConfiguration _screenConfiguration;
  WidgetSize _wigetSize;
  PageController _pageViewController;
  int _currentPosition = 0;
  String _buttonText = 'Suivent';
  List<OnBoarding> _onBordingList = [
    OnBoarding("assets/images/delivery.png", "Shopping à \ndomicile",
        "Avec DZ SHOPE vouz pouvez achetez,commondez,gagnez et a votre place"),
    OnBoarding("assets/images/cart.png", "Facilité de \nl'achat",
        "Vous n'avait pas un carte bancaire ,ok, nous somme la pour facilité votre vie"),
    OnBoarding("assets/images/money.png", "Payer à \nla réception",
        "Vous pouvez payer à la réception de votre commandes"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _pageViewController = PageController(
      initialPage: 0
    );
    super.initState();
  }
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenConfiguration = ScreenConfiguration(context);
    _wigetSize = WidgetSize(_screenConfiguration);
    print(_screenConfiguration.screenSize);
    double _padding = MediaQuery.of(context).size.width * 0.1;
    return Scaffold(
      body: Stack(children: [
        _drawPageView(context, _padding , _wigetSize.titleFontSize , _wigetSize.bodyFontSize),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                left: _padding, right: _padding, bottom: _padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: FlatButton(
                      child: Text(
                        _setButtonText(),
                        style: TextStyle(color: Colors.white, fontSize: _wigetSize.buttonFontSize),
                      ),
                      onPressed: () {
                        if(_currentPosition != _onBordingList.length -1){
                          _pageViewController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
                        }else{
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        }
                      }),
                ),
                _customIndicator(_onBordingList.length)
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _drawPageView(BuildContext context, double padding , double titleFontSize,double bodyFontSize) {
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _onBordingList.length,
        controller: _pageViewController,
        onPageChanged: (index) {
          setState(() {
            _currentPosition = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                color: Color(0xFFFE5C45),
              ),
              Padding(
                padding: EdgeInsets.only(left: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: ExactAssetImage(_onBordingList[index].image),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _onBordingList[index].title,
                          style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 48),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _onBordingList[index].body,
                            style: TextStyle(fontSize: bodyFontSize, color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _customIndicator(int length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _drawIndicator(length),
    );
  }

  List<Widget> _drawIndicator(int length) {
    List<Widget> indicators = [];
    for (int i = 0; i < length; i++) {
      indicators.add(indicator(
          (i == _currentPosition) ? Color(0xFFFFFFFF) : Colors.transparent,
          (i == length - 1) ? 0 : 8));
    }
    return indicators;
  }

  Widget indicator(Color color, double margin) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      width: _wigetSize.indicatorWidth,
      height: _wigetSize.indicatorHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, style: BorderStyle.solid),
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  String _setButtonText() {
    if (_currentPosition == _onBordingList.length - 1) {
      setState(() {
        _buttonText = 'Debut';
      });
    } else {
      setState(() {
        _buttonText = 'Suivent';
      });
    }
    return this._buttonText;
  }
}
