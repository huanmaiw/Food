import 'dart:async';

import 'package:flutter/material.dart';

class ImagesSlider extends StatefulWidget {
  const ImagesSlider({super.key});

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  int currentSlider = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          currentSlider = (currentSlider + 1) % 5;
          _pageController.animateToPage(
              currentSlider, duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        });
      }
    });
  }
@override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return Image.asset("images/Slider/sl${index+1}.jpg",fit: BoxFit.cover,
                    );
                  }
              ),
            ),
          ),
        ),
        Positioned.fill(bottom: 10,
            child: Align(
          alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                  List.generate(5, (index)=>AnimatedContainer(
                    duration: const Duration(
                        milliseconds: 300),
                    width: currentSlider== index?15 :8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentSlider == index? Colors.black : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),)),

              ),
        ))
      ],

    );
  }
}