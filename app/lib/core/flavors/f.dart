enum Flavor {
  dev,
  hml,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Very Good Coffee App [Dev]';
      case Flavor.hml:
        return 'Very Good Coffee App [Hml]';
      case Flavor.prod:
        return 'Very Good Coffee App [Prod]';
      default:
        return 'title';
    }
  }
}
