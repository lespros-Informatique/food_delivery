import 'package:flutter/material.dart';
import 'package:woli/models/order_model.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'livree':
        return AppColors.mainColor;
      case 'en_preparation':
        return AppColors.iconColor1;
      case 'payee':
        return AppColors.yellowColor;
      case 'en_attente':
        return AppColors.signColor;
      case 'annulee':
        return AppColors.iconColor2;
      default:
        return AppColors.signColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'livree':
        return 'Livrée';
      case 'en_preparation':
        return 'En préparation';
      case 'payee':
        return 'Payée';
      case 'en_attente':
        return 'En attente';
      case 'annulee':
        return 'Annulée';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Détail de commande", color: Colors.white),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Container(
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
                        text: order.codeCommande,
                        color: AppColors.titleColor,
                        size: Dimensions.font20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width15,
                          vertical: Dimensions.height10,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.statutCommande).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          border: Border.all(
                            color: _getStatusColor(order.statutCommande).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: SmallText(
                          text: _getStatusText(order.statutCommande),
                          color: _getStatusColor(order.statutCommande),
                          size: Dimensions.font14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height15),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.paraColor,
                        size: Dimensions.iconSize20,
                      ),
                      SizedBox(width: Dimensions.width10),
                      SmallText(
                        text: DateFormat('dd/MM/yyyy à HH:mm').format(order.createdAt),
                        color: AppColors.paraColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Restaurant Info
            Container(
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
                    text: "Restaurant",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  Row(
                    children: [
                      Icon(
                        Icons.store,
                        color: AppColors.mainColor,
                        size: Dimensions.iconSize24,
                      ),
                      SizedBox(width: Dimensions.width15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: order.restaurantName,
                              color: AppColors.titleColor,
                              size: Dimensions.font16,
                            ),
                            SizedBox(height: Dimensions.height5),
                            SmallText(
                              text: "Code: ${order.restaurantCode}",
                              color: AppColors.paraColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Client Info
            Container(
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
                    text: "Client",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.iconColor1,
                        size: Dimensions.iconSize24,
                      ),
                      SizedBox(width: Dimensions.width15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: order.clientName,
                              color: AppColors.titleColor,
                              size: Dimensions.font16,
                            ),
                            SizedBox(height: Dimensions.height5),
                            SmallText(
                              text: "Code: ${order.clientCode}",
                              color: AppColors.paraColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Order Items
            Container(
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
                    text: "Articles commandés",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  ...order.items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.width30,
                                height: Dimensions.height30,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(Dimensions.radius5),
                                ),
                                child: Center(
                                  child: SmallText(
                                    text: item.quantite.toString(),
                                    color: AppColors.mainColor,
                                    size: Dimensions.font14,
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: item.productName,
                                      color: AppColors.titleColor,
                                      size: Dimensions.font14,
                                    ),
                                    SizedBox(height: Dimensions.height5),
                                    SmallText(
                                      text: "Code: ${item.produitCode}",
                                      color: AppColors.paraColor,
                                      size: Dimensions.font12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SmallText(
                              text: "${item.prixUnitaire.toInt()} FCFA/unité",
                              color: AppColors.paraColor,
                              size: Dimensions.font12,
                            ),
                            SizedBox(height: Dimensions.height5),
                            BigText(
                              text: "${item.totalLigne.toInt()} FCFA",
                              color: AppColors.mainColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "Total de la commande",
                        color: AppColors.titleColor,
                        size: Dimensions.font18,
                      ),
                      BigText(
                        text: "${order.totalCommande.toInt()} FCFA",
                        color: AppColors.mainColor,
                        size: Dimensions.font18,
                      ),
                    ],
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
}