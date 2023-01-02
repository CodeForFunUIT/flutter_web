import 'package:flutter/cupertino.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fitWeb;
  final Function? onTap;
  const CustomImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.onTap,
    this.fitWeb = BoxFit.fitWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: height,
      width: width,
      image,
      fit: fitWeb,
    );
    //   ImageNetwork(
    //     image: image,
    //     height: height,
    //     width: width,
    //     fitWeb: fitWeb,
    //     onTap: onTap,
    //     onLoading: Shimmer.fromColors(
    //       baseColor: baseShimmerColor,
    //       highlightColor: highlightShimmerColor,
    //       child: SizedBox(height: height, width: width),
    //     ),
    //   );
  }
}
