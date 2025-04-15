import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/routes/router.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';

class Base extends StatelessWidget {
  final Widget child;

  const Base({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: canPop
              ? IconButton(
                  icon: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.brandBrown,
                  ),
                  onPressed: router.pop,
                )
              : null,
          backgroundColor: AppColors.white,
        ),
        body: SingleChildScrollView(child: child),
      ),
    );
  }
}
