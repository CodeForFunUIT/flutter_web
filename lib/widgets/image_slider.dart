import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/widgets/custom_image.dart';
import 'package:image_network/image_network.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({
    super.key,
    required this.images,
    required this.height,
    this.onPageChanged,
    this.initIndex = 0,
    this.runSpacing = 30,
    this.clipBehavior = Clip.none,
    this.borderRadius,
    this.indicatorSelectColor = Colors.white,
    this.indicatorNonSelectColor = Colors.white,
    this.padding,
    this.empty,
    this.enlargeCenterPage = false,
    this.onTap,
  });

  final List<String> images;

  final Widget? empty;

  final double? runSpacing;

  final double height;

  final Color? indicatorSelectColor;

  final Color? indicatorNonSelectColor;

  final EdgeInsets? padding;

  final Clip clipBehavior;

  final BorderRadius? borderRadius;

  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  final CarouselController controller = CarouselController();

  final GlobalKey<IndicatorState> _childKey = GlobalKey<IndicatorState>();

  final int initIndex;

  final void Function(int index)? onTap;

  final bool enlargeCenterPage;

  IndicatorState? get indicator => _childKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _carouselSlider(context),
        // Positioned.fill(
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Padding(
        //       padding: padding ?? const EdgeInsets.only(bottom: 20),
        //       child: Indicator(
        //         key: _childKey,
        //         controller: controller,
        //         itemCount: images.length,
        //         initIndex: initIndex,
        //         indicatorNonSelectColor: indicatorNonSelectColor,
        //         indicatorSelectColor: indicatorSelectColor,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _carouselSlider(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (_, constraint) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(20),
            ),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                clipBehavior: clipBehavior,
                aspectRatio: (constraint.maxWidth) / constraint.maxHeight,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: enlargeCenterPage,
                onPageChanged: (index, reason) {
                  onPageChanged?.call(index, reason);
                  indicator?.change(index);
                },
                scrollDirection: Axis.horizontal,
              ),
              carouselController: controller,
              itemCount: images.length,
              itemBuilder: (_, index, __) => ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                child: images.isEmpty
                    ? empty
                    : InkWell(
                        onTap: onTap != null
                            ? () {
                                onTap!.call(index);
                              }
                            : null,
                        child: CustomImage(
                          image: images[index],
                          fitWeb: BoxFitWeb.contain,
                          height: constraint.maxHeight,
                          width: constraint.maxWidth,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Indicator extends StatefulWidget {
  const Indicator({
    super.key,
    required this.itemCount,
    required this.controller,
    this.indicatorNonSelectColor,
    this.indicatorSelectColor,
    this.initIndex = 0,
  });

  final CarouselController controller;
  final int itemCount;
  final int initIndex;
  final Color? indicatorSelectColor;
  final Color? indicatorNonSelectColor;

  @override
  State<Indicator> createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> {
  CarouselController get controller => widget.controller;
  int get itemCount => widget.itemCount;
  late int _select;
  late Color _indicatorSelectColor;
  late Color _indicatorNonSelectColor;

  @override
  void initState() {
    super.initState();
    _select = widget.initIndex;
    _indicatorNonSelectColor = widget.indicatorNonSelectColor!;
    _indicatorSelectColor = widget.indicatorSelectColor!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        itemCount,
        _indicator,
        growable: false,
      ).toList(),
    );
  }

  Widget _indicator(int index) {
    bool isSelect = index == _select;
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        height: 8,
        width: isSelect ? 32 : 8,
        decoration: BoxDecoration(
          color: isSelect ? _indicatorSelectColor : _indicatorNonSelectColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onTap: () {
        controller.animateToPage(index);
        change(index);
      },
    );
  }

  void change(int index) {
    if (index == _select) return;
    setState(() {
      _select = index;
    });
  }
}
