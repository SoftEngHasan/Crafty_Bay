import 'package:crafty_bay/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/category_card_widget.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/remarks_title.dart';
import '../widgets/home_widgets/home_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(ImageAssets.craftyBayNavLogoSVG),
              const Spacer(),
              CircularIconButton(
                onTap: () {},
                icon: Icons.person,
              ),
              const SizedBox(
                width: 10,
              ),
              CircularIconButton(
                onTap: () {},
                icon: Icons.call,
              ),
              const SizedBox(
                width: 10,
              ),
              CircularIconButton(
                onTap: () {},
                icon: Icons.notifications_active,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Search',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 10,
              ),
              const HomeSlider(),
              const SizedBox(
                height: 8,
              ),
              RemarksTitle(
                title: 'All Categories',
                onTap: () {},
              ),
              const SizedBox(height: 8,),
              SizedBox(
                height: 90,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const CategoryCardWidget();
                    }),
              ),
              const SizedBox(
                height: 8,
              ),
              RemarksTitle(
                title: 'Popular',
                onTap: () {},
              ),
              const SizedBox(height: 8,),
              SizedBox(
                height: 90,
                child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const CategoryCardWidget();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

