import 'package:flutter/widgets.dart';

/// App name: `Flutter App Test`
const String APP_NAME = 'Flutter App Test';

const String BASE_URL = 'https://sandbox.nellys-coin.ejaraapis.xyz';

// General color
const Color white = Color(0xffffffff);
const Color gray = Color(0xfffafafa);
const Color blue = Color(0xff4a5aed);

// Images
const String IMG_BG = 'assets/images/backgroundIcons.png';
const String IMG_LOGO = 'assets/images/ejaraLogoWhite.png';

//--------------------------- screen height & width ----------------------------

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}
