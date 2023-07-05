import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/category_screen/item_details.dart';
import 'package:ecommerce_app/views/home_screen/components/featured_button.dart';
import 'package:ecommerce_app/views/home_screen/search_screen.dart';
import 'package:ecommerce_app/widgets_common/home_buttons.dart';
import 'package:ecommerce_app/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
// top search bar
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                   suffixIcon: Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            10.heightBox,

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
// swiper brands
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    10.heightBox,

                    // deals buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 2.5,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todayDeal : flashsale,
                              )),
                    ),

                    10.heightBox,

                    // 2nd swiper
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

                    10.heightBox,

                    // category buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topSellers,
                              )),
                    ),

                    20.heightBox,

                    // featured categories
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                icon: featuredImages1[index],
                                title: featuredTitle1[index],
                              ),
                              10.heightBox,
                              featuredButton(
                                icon: featuresImages2[index],
                                title: featuredTitle2[index],
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),

// featured products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FireStoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;

                                    return Row(
                                      children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              featuredData[index]['p_imgs'][0],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            10.heightBox,
                                            "${featuredData[index]['p_name']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${featuredData[index]['p_price']}"
                                                .numCurrency
                                                .text
                                                .fontFamily(bold)
                                                .size(16)
                                                .color(redColor)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .white
                                            .roundedSM
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemDetails(
                                                title:
                                                    "${featuredData[index]['p_name']}",
                                                data: featuredData[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),

// third swiper
                    20.heightBox,
                    VxSwiper.builder(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),

// all products section
                    20.heightBox,
                    StreamBuilder(
                      stream: FireStoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    allproductsdata[index]['p_imgs'][0],
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
                                      .text
                                      .fontFamily(bold)
                                      .size(16)
                                      .color(redColor)
                                      .make(),
                                  10.heightBox,
                                ],
                              )
                                  .box
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .white
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ));
                              });
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
