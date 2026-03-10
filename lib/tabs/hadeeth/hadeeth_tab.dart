import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:islami_app/tabs/hadeeth/Widget/hadeeth_item.dart';

class HadeethTab extends StatelessWidget {
  const HadeethTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: CarouselSlider(
        options: CarouselOptions(
          height: height,
          aspectRatio: 313.34 / 618,
          enlargeCenterPage: true,
        ),
        items: List.generate(50, (index) => index).map((index) {
          return HadeethItem(index: index);
        }).toList(),
      ),
    );
  }
}
