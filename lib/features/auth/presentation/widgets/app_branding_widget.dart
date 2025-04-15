import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/utils/assets_path.dart';
import 'package:flutter_svg/svg.dart';

class AppBranding extends StatelessWidget {
  const AppBranding({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 21,
          child: SvgPicture.asset(AssetPaths.logoVectorTop),
        ),
        Positioned(
          bottom: 21,
          child: SvgPicture.asset(AssetPaths.logoVectorBottom),
        ),
        Image.asset(AssetPaths.logoMain, height: 222),
      ],
    );
  }
}
