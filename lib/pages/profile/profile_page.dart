import 'package:flutter/material.dart';
import 'package:woli/data/fake_data.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Mon Profil", color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.height20),

            // Profile Header Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: Dimensions.height30,
                    backgroundColor: AppColors.buttonBackgroundColor,
                    child: Icon(
                      Icons.person,
                      size: Dimensions.iconSize60,
                      color: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),

                  // Name
                  BigText(
                    text: fakeUser.name,
                    color: AppColors.titleColor,
                    size: Dimensions.font20,
                  ),
                  SizedBox(height: Dimensions.height5),

                  // User Code
                  SmallText(
                    text: "Code: ${fakeUser.id}",
                    color: AppColors.paraColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Profile Information Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Informations personnelles",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height20),
                  _buildProfileItem(
                    icon: Icons.email,
                    title: "Email",
                    value: fakeUser.email,
                  ),
                  SizedBox(height: Dimensions.height15),
                  _buildProfileItem(
                    icon: Icons.phone,
                    title: "Téléphone",
                    value: fakeUser.phone,
                  ),
                  SizedBox(height: Dimensions.height15),
                  _buildProfileItem(
                    icon: Icons.location_on,
                    title: "Adresse",
                    value: fakeUser.address,
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Statistics Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Statistiques",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        icon: Icons.receipt_long,
                        value: fakeOrders.length.toString(),
                        label: "Commandes",
                        color: AppColors.mainColor,
                      ),
                      _buildStatItem(
                        icon: Icons.check_circle,
                        value: fakeOrders.where((order) => order.statutCommande == 'livree').length.toString(),
                        label: "Livrées",
                        color: AppColors.iconColor1,
                      ),
                      _buildStatItem(
                        icon: Icons.favorite,
                        value: "5", // Fake favorite count
                        label: "Favoris",
                        color: AppColors.iconColor2,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Recent Orders Preview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "Commandes récentes",
                        color: AppColors.titleColor,
                        size: Dimensions.font16,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to orders page
                          Get.toNamed('/orders');
                        },
                        child: SmallText(
                          text: "Voir tout",
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height15),
                  if (fakeOrders.isNotEmpty)
                    ...fakeOrders.take(2).map((order) => Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.height10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallText(
                                  text: order.codeCommande,
                                  color: AppColors.titleColor,
                                ),
                                SizedBox(height: Dimensions.height5),
                                SmallText(
                                  text: "${order.items.length} article${order.items.length > 1 ? 's' : ''}",
                                  color: AppColors.paraColor,
                                  size: Dimensions.font12,
                                ),
                              ],
                            ),
                          ),
                          SmallText(
                            text: "${order.totalCommande.toInt()} FCFA",
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                    )),
                  if (fakeOrders.isEmpty)
                    Center(
                      child: SmallText(
                        text: "Aucune commande",
                        color: AppColors.paraColor,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.width20,
          height: Dimensions.height20,
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
          child: Icon(
            icon,
            color: AppColors.mainColor,
            size: Dimensions.iconSize16,
          ),
        ),
        SizedBox(width: Dimensions.width15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: title,
                color: AppColors.paraColor,
                size: Dimensions.font14,
              ),
              SizedBox(height: Dimensions.height5),
              SmallText(
                text: value,
                color: AppColors.titleColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: Dimensions.width25,
          height: Dimensions.height25,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          child: Icon(
            icon,
            color: color,
            size: Dimensions.iconSize24,
          ),
        ),
        SizedBox(height: Dimensions.height10),
        BigText(
          text: value,
          color: AppColors.titleColor,
          size: Dimensions.font16,
        ),
        SmallText(
          text: label,
          color: AppColors.paraColor,
        ),
      ],
    );
  }
}