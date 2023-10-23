import 'package:crafty_bay/data/models/product_details.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:crafty_bay/presentation/ui/widgets/home_widgets/product_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utility/color_extension.dart';
import '../utility/app_colors.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColor = 0;
  int _selectedSizes = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.getProductDetailsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImageSlider(
                    imageList: [
                      productDetailsController.productDetails.img1 ?? '',
                      productDetailsController.productDetails.img2 ?? '',
                      productDetailsController.productDetails.img3 ?? '',
                      productDetailsController.productDetails.img4 ?? '',
                    ],
                  ),
                  productDetailsAppBar
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              productDetails(productDetailsController.productDetails,
                  productDetailsController.availableColors),
              addToCartBottomContainer(
                productDetailsController.productDetails,
                productDetailsController.availableColors,
                productDetailsController.availableSizes,
              )
            ],
          ),
        );
      }),
    );
  }

  Container addToCartBottomContainer(
      ProductDetails details, List<String> colors, List<String> size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '\$230',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              if (addToCartController.addToCartInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  addToCartController.addToCart(
                    details.id!,
                    colors[_selectedColor],
                    size[_selectedSizes],
                  ).then((result) {
                    if(result){
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Added to Cart',
                        message: 'This product has been added to cart',
                        duration: Duration(seconds: 2),
                      ));
                    }else{
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Failed to add cart',
                        message: 'Try again!',
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  });
                },
                child: const Text('Add to Cart'),
              );
            }),
          )
        ],
      ),
    );
  }

  AppBar get productDetailsAppBar {
    return AppBar(
      title: const Text(
        'Product Details',
        style: TextStyle(color: Colors.black54),
      ),
      leading: const BackButton(
        color: Colors.black54,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Expanded productDetails(ProductDetails productDetails, List<String> colors) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      productDetails.product?.title ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          fontSize: 18),
                    ),
                  ),
                  CustomStepper(
                    lowerLimit: 1,
                    upperLimit: 10,
                    stepValue: 1,
                    value: 1,
                    onChange: (newValue) {
                      print(newValue);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.yellow,
                      ),
                      Text(
                        '${productDetails.product?.star ?? 0}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Review'),
                  ),
                  const Card(
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
              const Text(
                'Color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 28,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: productDetails.color?.split(',').length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        _selectedColor = index;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: HexColor.fromHex(colors[index]),
                        child: _selectedColor == index
                            ? const Icon(Icons.done, color: Colors.white)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                'Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 28,
                child: SizePicker(
                  sizes: productDetails.size?.split(',') ?? [],
                  onSelected: (int selectedSize) {
                    _selectedSizes = selectedSize;
                  },
                  initiallySelected: 0,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(productDetails.product?.shortDes ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
