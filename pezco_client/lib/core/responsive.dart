import 'package:flutter/material.dart';

class ResponsiveSize {
  static const double desktopLarge = 1920;
  static const double desktop = 1200;
  static const double tablet = 700;
  static const double mobile = 400;

  static DeviceType getDeviceType(double width) {
    if (width >= desktop) {
      return DeviceType.desktop;
    } else if (width >= tablet) {
      return DeviceType.tablet;
    } else if (width >= mobile) {
      return DeviceType.mobile;
    } else {
      return DeviceType.small;
    }
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tablet && width < desktop;
  }

  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < tablet;
  }

  static bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  static bool isCompactDevice(BuildContext context) {
    return MediaQuery.of(context).size.width < tablet;
  }

  @Deprecated('Use isTablet() instead')
  static bool isMedium(BuildContext context) => isTablet(context);

  @Deprecated('Use isMobile() instead')
  static bool small(BuildContext context) => isMobile(context);

  static double getSidebarWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    switch (deviceType) {
      case DeviceType.desktop:
        return 200;
      case DeviceType.tablet:
        return 100;
      case DeviceType.mobile:
        return 0;
      case DeviceType.small:
        return 0;
    }
  }

  static double getHeaderHeight(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size.width);
    
    switch (deviceType) {
      case DeviceType.desktop:
        return 100;
      case DeviceType.tablet:
        return 80;
      case DeviceType.mobile:
        return 70;
      case DeviceType.small:
        return 60;
    }
  }

  static double getLogoSize(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size.width);
    
    switch (deviceType) {
      case DeviceType.desktop:
        return 110;
      case DeviceType.tablet:
        return 50;
      case DeviceType.mobile:
        return 40;
      case DeviceType.small:
        return 35;
    }
  }

  static EdgeInsets getHeaderPadding(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size.width);
    
    switch (deviceType) {
      case DeviceType.desktop:
        return const EdgeInsets.all(20);
      case DeviceType.tablet:
        return const EdgeInsets.all(15);
      case DeviceType.mobile:
        return const EdgeInsets.all(10);
      case DeviceType.small:
        return const EdgeInsets.all(5);
    }
  }

  static double getPiscinaWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    switch (deviceType) {
      case DeviceType.desktop:
        return 220;
      case DeviceType.tablet:
        return 160;
      case DeviceType.mobile:
        return 110;
      case DeviceType.small:
        return 90;
    }
  }

  static double getPiscinaHeight(BuildContext context) {
    final deviceType = getDeviceType(MediaQuery.of(context).size.width);

    switch (deviceType) {
      case DeviceType.desktop:
        return 400;
      case DeviceType.tablet:
        return 300;
      case DeviceType.mobile:
        return 80;
      case DeviceType.small:
        return 60;
    }
  }

  static double getProyeccionWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.desktop:
        return (width / 1920) * 450;
      case DeviceType.tablet:
        return 250;
      case DeviceType.mobile:
        return width - 40;
      case DeviceType.small:
        return width - 30;
    }
  }

  static double getProyeccionWidthMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    switch (deviceType) {
      case DeviceType.desktop:
        return 450;
      case DeviceType.tablet:
        return 250;
      case DeviceType.mobile:
        return 110;
      case DeviceType.small:
        return 90;
    }
  }
}

enum DeviceType {
  desktop,
  tablet,
  mobile,
  small,
}
