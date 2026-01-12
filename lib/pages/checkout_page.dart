import 'package:flutter/material.dart';
import 'package:woli/controllers/cart_controller.dart';
import 'package:woli/utils/colors.dart';
import 'package:woli/utils/dimensions.dart';
import 'package:woli/widgets/big_text.dart';
import 'package:woli/widgets/small_text.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartController cartController = Get.find<CartController>();
  String selectedPaymentMethod = 'orange_money';
  String selectedDeliveryAddress = 'home';

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'orange_money',
      'name': 'Orange Money',
      'icon': Icons.account_balance_wallet,
      'color': Colors.orange,
    },
    {
      'id': 'wave',
      'name': 'Wave',
      'icon': Icons.waves,
      'color': Colors.blue,
    },
    {
      'id': 'card',
      'name': 'Carte bancaire',
      'icon': Icons.credit_card,
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> deliveryAddresses = [
    {
      'id': 'home',
      'name': 'Domicile',
      'address': '123 Rue de la Liberté, Dakar',
      'icon': Icons.home,
    },
    {
      'id': 'work',
      'name': 'Bureau',
      'address': '456 Avenue du Travail, Dakar',
      'icon': Icons.work,
    },
  ];

  double get subtotal => cartController.cart.totalAmount;
  double get deliveryFee => 1500;
  double get tax => subtotal * 0.15;
  double get total => subtotal + deliveryFee + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Finaliser la commande", color: Colors.white),
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
            // Order Summary
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
                    text: "Récapitulatif de commande",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  ...cartController.cart.items.map((item) => Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.height10),
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
                              text: item.quantity.toString(),
                              color: AppColors.mainColor,
                              size: Dimensions.font12,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        Expanded(
                          child: SmallText(
                            text: item.product.name ?? "Produit",
                            color: AppColors.titleColor,
                          ),
                        ),
                        SmallText(
                          text: "${(item.product.price ?? 0) * item.quantity} FCFA",
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  )),
                  Divider(),
                  _buildPriceRow("Sous-total", "${subtotal.toInt()} FCFA"),
                  SizedBox(height: Dimensions.height5),
                  _buildPriceRow("Frais de livraison", "${deliveryFee.toInt()} FCFA"),
                  SizedBox(height: Dimensions.height5),
                  _buildPriceRow("Taxes", "${tax.toInt()} FCFA"),
                  SizedBox(height: Dimensions.height10),
                  Divider(),
                  _buildPriceRow("Total", "${total.toInt()} FCFA", isTotal: true),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Delivery Address
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
                    text: "Adresse de livraison",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  ...deliveryAddresses.map((address) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDeliveryAddress = address['id'];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      padding: EdgeInsets.all(Dimensions.width15),
                      decoration: BoxDecoration(
                        color: selectedDeliveryAddress == address['id']
                            ? AppColors.mainColor.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        border: Border.all(
                          color: selectedDeliveryAddress == address['id']
                              ? AppColors.mainColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            address['icon'],
                            color: selectedDeliveryAddress == address['id']
                                ? AppColors.mainColor
                                : AppColors.paraColor,
                          ),
                          SizedBox(width: Dimensions.width15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: address['name'],
                                  color: AppColors.titleColor,
                                  size: Dimensions.font14,
                                ),
                                SizedBox(height: Dimensions.height5),
                                SmallText(
                                  text: address['address'],
                                  color: AppColors.paraColor,
                                  size: Dimensions.font12,
                                ),
                              ],
                            ),
                          ),
                          if (selectedDeliveryAddress == address['id'])
                            Icon(
                              Icons.check_circle,
                              color: AppColors.mainColor,
                            ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height20),

            // Payment Method
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
                    text: "Mode de paiement",
                    color: AppColors.titleColor,
                    size: Dimensions.font16,
                  ),
                  SizedBox(height: Dimensions.height15),
                  ...paymentMethods.map((method) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = method['id'];
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      padding: EdgeInsets.all(Dimensions.width15),
                      decoration: BoxDecoration(
                        color: selectedPaymentMethod == method['id']
                            ? method['color'].withOpacity(0.1)
                            : Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(Dimensions.radius10),
                        border: Border.all(
                          color: selectedPaymentMethod == method['id']
                              ? method['color']
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method['icon'],
                            color: selectedPaymentMethod == method['id']
                                ? method['color']
                                : AppColors.paraColor,
                          ),
                          SizedBox(width: Dimensions.width15),
                          Expanded(
                            child: BigText(
                              text: method['name'],
                              color: AppColors.titleColor,
                              size: Dimensions.font14,
                            ),
                          ),
                          if (selectedPaymentMethod == method['id'])
                            Icon(
                              Icons.check_circle,
                              color: method['color'],
                            ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(height: Dimensions.height30),

            // Confirm Order Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 10.0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _confirmOrder,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainColor.withOpacity(0.3),
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: BigText(
                          text: "Confirmer la commande",
                          color: Colors.white,
                          size: Dimensions.font16,
                        ),
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
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallText(
          text: label,
          color: isTotal ? AppColors.titleColor : AppColors.paraColor,
          size: isTotal ? Dimensions.font14 : Dimensions.font12,
        ),
        SmallText(
          text: amount,
          color: isTotal ? AppColors.mainColor : AppColors.titleColor,
          size: isTotal ? Dimensions.font14 : Dimensions.font12,
        ),
      ],
    );
  }

  void _confirmOrder() {
    // Show loading with modern design
    Get.dialog(
      Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(Dimensions.width30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Dimensions.width60,
                  height: Dimensions.width60,
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                    strokeWidth: 4,
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                BigText(
                  text: "Traitement du paiement...",
                  color: AppColors.titleColor,
                  size: Dimensions.font16,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Close loading dialog

      // Clear cart
      cartController.clearCart();

      // Show modern success animation
      Get.dialog(
        _buildSuccessDialog(),
        barrierDismissible: false,
      );
    });
  }

  Widget _buildSuccessDialog() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          padding: EdgeInsets.all(Dimensions.width30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated success icon
              Container(
                width: Dimensions.width100,
                height: Dimensions.width100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: Dimensions.iconSize50,
                ),
              ),

              SizedBox(height: Dimensions.height25),

              // Success message
              BigText(
                text: "🎉 Commande confirmée !",
                color: AppColors.titleColor,
                size: Dimensions.font20,
              ),

              SizedBox(height: Dimensions.height15),

              // Order details
              Container(
                padding: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
                child: Column(
                  children: [
                    _buildOrderInfoRow("Numéro de commande", "#${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}"),
                    SizedBox(height: Dimensions.height10),
                    _buildOrderInfoRow("Temps estimé", "25-35 minutes"),
                    SizedBox(height: Dimensions.height10),
                    _buildOrderInfoRow("Adresse", "123 Rue de la Liberté, Dakar"),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height20),

              // Notification message
              Container(
                padding: EdgeInsets.all(Dimensions.width15),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  border: Border.all(
                    color: AppColors.mainColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_active,
                      color: AppColors.mainColor,
                      size: Dimensions.iconSize24,
                    ),
                    SizedBox(width: Dimensions.width10),
                    Expanded(
                      child: Text(
                        "Vous recevrez une notification dès que votre commande sera prête.",
                        style: TextStyle(
                          color: AppColors.titleColor,
                          fontSize: Dimensions.font14,
                          fontFamily: 'Roboto',
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height30),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        Get.toNamed('/orders'); // Go to orders page
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.mainColor),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                      child: Text(
                        "Voir mes commandes",
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: Dimensions.font14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        Get.offAllNamed('/'); // Go to home
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Retour à l'accueil",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.font14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.paraColor,
            fontSize: Dimensions.font14,
            fontFamily: 'Roboto',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.titleColor,
            fontSize: Dimensions.font14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}