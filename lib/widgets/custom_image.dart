import 'package:flutter/cupertino.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:image_network/image_network.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFitWeb fitWeb;
  final Function? onTap;
  const CustomImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.onTap,
    this.fitWeb = BoxFitWeb.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ImageNetwork(
      image: image,
      height: height,
      width: width,
      fitWeb: fitWeb,
      onTap: onTap,
      onLoading: Shimmer.fromColors(
        baseColor: baseShimmerColor,
        highlightColor: highlightShimmerColor,
        child: SizedBox(height: height, width: width),
      ),
    );
  }
}
