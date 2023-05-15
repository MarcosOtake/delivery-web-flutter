class TextStyles {
  static TextStyles? _instance;
  // Avoid self isntance
  TextStyles._();
  static TextStyles get instance{
    _instance??=  TextStyles._();
    return _instance!;
   }

String get fontFamile => 'mpluas1';

}