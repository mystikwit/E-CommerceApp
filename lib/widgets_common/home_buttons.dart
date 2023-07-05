import 'package:ecommerce_app/consts/consts.dart';

Widget homeButtons({width, height, icon,String? title, onpress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon, width: 26),
      10.heightBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}
