import 'package:flutter/material.dart';

enum ScreenSize{
  Small,Medium,Large,XLarge,XXLarge
}

class ScreenConfiguration{
  double screenWidth,screenHeight;
  ScreenSize screenSize;

  ScreenConfiguration(BuildContext context){
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    _setScreenSize();
  }

  void _setScreenSize(){
    if(this.screenWidth >= 320 && this.screenWidth < 375){
        this.screenSize = ScreenSize.Small;
    }
    if(this.screenWidth >= 375 && this.screenWidth < 414){
      this.screenSize = ScreenSize.Medium;
    }
    if(this.screenWidth >= 414 && this.screenWidth < 800){
      this.screenSize = ScreenSize.Large;
    }
    if(this.screenWidth >= 800 && this.screenWidth < 1280){
      this.screenSize = ScreenSize.XLarge;
    }
    if(this.screenWidth >= 1280){
      this.screenSize = ScreenSize.XXLarge;
    }

  }


}



//Widget resolutions class
class WidgetSize{
  double titleFontSize,bodyFontSize , buttonFontSize , indicatorWidth,indicatorHeight;
  ScreenConfiguration _screenConfiguration;

  WidgetSize(ScreenConfiguration screenConfiguration){
    this._screenConfiguration = screenConfiguration;
    init();
  }

  void init() {
    switch(this._screenConfiguration.screenSize){
      case ScreenSize.Small :
        this.titleFontSize = 20;
        this.bodyFontSize = 12;
        this.buttonFontSize = 14;
        this.indicatorWidth = 7;
        this.indicatorHeight=7;
        break;
      case ScreenSize.Medium :
        this.titleFontSize = 28;
        this.bodyFontSize = 14;
        this.buttonFontSize = 14;
        this.indicatorWidth = 8;
        this.indicatorHeight=8;
        break;
      case ScreenSize.Large :
        this.titleFontSize = 32;
        this.bodyFontSize = 18;
        this.buttonFontSize = 16;
        this.indicatorWidth = 10;
        this.indicatorHeight=10;
        break;
      case ScreenSize.XLarge :
        this.titleFontSize = 32;
        this.bodyFontSize = 18;
        this.buttonFontSize = 16;
        this.indicatorWidth = 10;
        this.indicatorHeight=10;
        break;
      case ScreenSize.XXLarge :
        this.titleFontSize = 48;
        this.bodyFontSize = 22;
        this.buttonFontSize = 20;
        this.indicatorWidth = 14;
        this.indicatorHeight=14;
        break;
      default:
        this.titleFontSize = 32;
        this.bodyFontSize = 18;
        this.buttonFontSize = 24;
        this.indicatorWidth = 10;
        this.indicatorHeight=10;
        break;
    }
  }
}