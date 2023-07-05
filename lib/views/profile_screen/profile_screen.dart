import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/chat_screen/messaging_screen.dart';
import 'package:ecommerce_app/views/orders_screen/orders_screen.dart';
import 'package:ecommerce_app/views/profile_screen/edit_profile_screen.dart';
import 'package:ecommerce_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:ecommerce_app/widgets_common/bg_widget.dart';
import 'package:ecommerce_app/views/profile_screen/components/details_card.dart';
import 'package:ecommerce_app/widgets_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  get nameController => null;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(const ProfileScreen());

    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
        stream: FireStoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  // edit profile button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                        )).onTap(() {
                      controller.nameController.text = data['name'];
                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),

                  // users details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageURL'] == ''
                            ? Image.asset(imgProfile2,
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageURL'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: whiteColor,
                              ),
                            ),
                            onPressed: () {},
                            child:
                                logout.text.fontFamily(semibold).white.make())
                      ],
                    ),
                  ),

                  20.heightBox,
                  FutureBuilder(
                    future: FireStoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else {
                        var countData = snapshot.data;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: countData[0].toString(),
                                title: "in your cart",
                                width: context.screenWidth / 3.3),
                            detailsCard(
                                count: countData[1].toString(),
                                title: "in your wishlist",
                                width: context.screenWidth / 3.3),
                            detailsCard(
                                count: data[2].toString(),
                                title: "your orders",
                                width: context.screenWidth / 3.3),
                          ],
                        );
                      }
                    },
                  ),

                  // buttons section

                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const OrdersScreen());
                              break;
                            case 1:
                              Get.to(() => const WishlistScreen());
                              break;
                            case 2:
                              Get.to(() => const MessageScreen());
                              break;
                          }
                        },
                        leading: Image.asset(
                          profileButtonsIcon[index],
                          width: 22,
                        ),
                        title: profileButtonsList[index].text.make(),
                      );
                    },
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .margin(const EdgeInsets.all(12))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make(),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}
