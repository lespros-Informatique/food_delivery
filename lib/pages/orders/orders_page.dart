import 'package:flutter/material.dart';
import 'package:woli/data/fake_data.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:woli/pages/orders/order_detail_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

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
        title: BigText(text: "Mes Commandes", color: Colors.white),
        centerTitle: true,
      ),
      body: fakeOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: Dimensions.iconSize100, color: AppColors.signColor),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: "Historique des commandes", color: AppColors.titleColor),
                  SizedBox(height: Dimensions.height10),
                  SmallText(text: "Vos commandes passées apparaîtront ici"),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(Dimensions.width20),
              itemCount: fakeOrders.length,
              itemBuilder: (context, index) {
                final order = fakeOrders[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => OrderDetailPage(order: order));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height15,
                    ),
                    padding: EdgeInsets.all(Dimensions.width15),
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: order.codeCommande,
                                    color: AppColors.titleColor,
                                    size: Dimensions.font16,
                                  ),
                                  SizedBox(height: Dimensions.height5),
                                  SmallText(
                                    text: DateFormat('dd/MM/yyyy à HH:mm').format(order.createdAt),
                                    color: AppColors.paraColor,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height5,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order.statutCommande).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                                border: Border.all(
                                  color: _getStatusColor(order.statutCommande).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (order.statutCommande == 'livree')
                                    Icon(
                                      Icons.check_circle,
                                      color: _getStatusColor(order.statutCommande),
                                      size: Dimensions.iconSize14,
                                    )
                                  else if (order.statutCommande == 'en_preparation')
                                    Icon(
                                      Icons.restaurant,
                                      color: _getStatusColor(order.statutCommande),
                                      size: Dimensions.iconSize14,
                                    )
                                  else if (order.statutCommande == 'annulee')
                                    Icon(
                                      Icons.cancel,
                                      color: _getStatusColor(order.statutCommande),
                                      size: Dimensions.iconSize14,
                                    ),
                                  SizedBox(width: Dimensions.width3),
                                  SmallText(
                                    text: _getStatusText(order.statutCommande),
                                    color: _getStatusColor(order.statutCommande),
                                    size: Dimensions.font11,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height15),
                        Row(
                          children: [
                            Icon(
                              Icons.store,
                              color: AppColors.mainColor,
                              size: Dimensions.iconSize20,
                            ),
                            SizedBox(width: Dimensions.width10),
                            Expanded(
                              child: SmallText(
                                text: order.restaurantName,
                                color: AppColors.titleColor,
                                size: Dimensions.font14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.iconColor2,
                              size: Dimensions.iconSize20,
                            ),
                            SizedBox(width: Dimensions.width10),
                            Expanded(
                              child: SmallText(
                                text: "123 Rue de la Liberté, Dakar",
                                color: AppColors.paraColor,
                                size: Dimensions.font14,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.yellowColor,
                              size: Dimensions.iconSize20,
                            ),
                            SizedBox(width: Dimensions.width10),
                            SmallText(
                              text: "Livraison estimée: 25-35 min",
                              color: AppColors.titleColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: AppColors.iconColor1,
                              size: Dimensions.iconSize20,
                            ),
                            SizedBox(width: Dimensions.width10),
                            SmallText(
                              text: "Payé • Orange Money",
                              color: AppColors.titleColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height15),
                        Container(
                          padding: EdgeInsets.all(Dimensions.width15),
                          decoration: BoxDecoration(
                            color: AppColors.buttonBackgroundColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SmallText(
                                      text: "${order.items.length} article${order.items.length > 1 ? 's' : ''} commandé${order.items.length > 1 ? 's' : ''}",
                                      color: AppColors.titleColor,
                                      size: Dimensions.font14,
                                    ),
                                  ),
                                  SmallText(
                                    text: "Sous-total: ${(order.totalCommande * 0.85).toInt()} FCFA",
                                    color: AppColors.mainColor,
                                    size: Dimensions.font14,
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height10),
                              Divider(height: 1),
                              SizedBox(height: Dimensions.height10),
                              ...order.items.take(2).map((item) => Padding(
                                padding: EdgeInsets.only(bottom: Dimensions.height8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Dimensions.width20,
                                      height: Dimensions.height20,
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                                      ),
                                      child: Center(
                                        child: SmallText(
                                          text: item.quantite.toString(),
                                          color: AppColors.mainColor,
                                          size: Dimensions.font12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                      child: SmallText(
                                        text: item.productName,
                                        color: AppColors.titleColor,
                                        size: Dimensions.font14,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10),
                                    SmallText(
                                      text: "${item.prixUnitaire.toInt()} FCFA",
                                      color: AppColors.paraColor,
                                      size: Dimensions.font12,
                                    ),
                                  ],
                                ),
                              )),
                              if (order.items.length > 2)
                                Padding(
                                  padding: EdgeInsets.only(top: Dimensions.height8),
                                  child: SmallText(
                                    text: "+ ${order.items.length - 2} autre${order.items.length - 2 > 1 ? 's' : ''} article${order.items.length - 2 > 1 ? 's' : ''}...",
                                    color: AppColors.paraColor,
                                    size: Dimensions.font12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: Dimensions.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: "Sous-total",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                            SmallText(
                              text: "${(order.totalCommande * 0.85).toInt()} FCFA",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: "Frais de livraison",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                            SmallText(
                              text: "1500 FCFA",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(
                              text: "Taxes",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                            SmallText(
                              text: "${(order.totalCommande * 0.15).toInt()} FCFA",
                              color: AppColors.paraColor,
                              size: Dimensions.font14,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.height10),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: BigText(
                                text: "Total payé",
                                color: AppColors.titleColor,
                                size: Dimensions.font16,
                              ),
                            ),
                            BigText(
                              text: "${order.totalCommande.toInt()} FCFA",
                              color: AppColors.mainColor,
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                        if (order.statutCommande == 'livree')
                          Padding(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      // Reorder functionality
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: AppColors.mainColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
                                    ),
                                    child: SmallText(
                                      text: "Commander à nouveau",
                                      color: AppColors.mainColor,
                                      size: Dimensions.font14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}