import 'package:crafty_bay/data/models/cart_list_data.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';
import 'custom_stepper.dart';

class CartProductCard extends StatelessWidget {
  final CartListData cartListData;

  const CartProductCard({
    Key? key,
    required this.cartListData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                /// put the network image here
                image: NetworkImage(cartListData.productData?.image ?? ''),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartListData.productData?.title ?? 'Unknown',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black54),
                                children: [
                                  TextSpan(
                                      text:
                                          'Color: ${cartListData.color ?? ''}  '),
                                  TextSpan(text: 'Size: ${cartListData.size ?? ''}'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${cartListData.productData?.price ?? 10}',
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      SizedBox(
                        width: 85,
                        child: FittedBox(
                          child: CustomStepper(
                            lowerLimit: 1,
                            upperLimit: 10,
                            stepValue: 1,
                            value: cartListData.numberOfItems ?? 1,
                            onChange: (int value) {
                              print(value);
                              Get.find<CartListController>().changeItem(cartListData.id!, value);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
