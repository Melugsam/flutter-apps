import 'dart:math';
import 'dart:ui';

Color getRandomColor() {
  Color lightBlue = const Color.fromRGBO(233, 244, 251, 1);
  Color lightGreen = const Color.fromRGBO(233, 255, 238, 1.0);
  Color lightRed = const Color.fromRGBO(252, 225, 228, 1.0);
  Color lightPink = const Color.fromRGBO(255, 222, 241, 1.0);
  Color lightPurple = const Color.fromRGBO(242, 208, 255, 1.0);
  Color lightYellow = const Color.fromRGBO(255, 246, 208, 1.0);
  Color lightOrange = const Color.fromRGBO(255, 222, 196, 1.0);

  List<Color> colors = [
    lightBlue,
    lightGreen,
    lightRed,
    lightPink,
    lightPurple,
    lightYellow,
    lightOrange
  ];

  Random random = Random();
  return colors[random.nextInt(colors.length)];
}
