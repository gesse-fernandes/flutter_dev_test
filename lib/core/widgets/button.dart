import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';

enum TypeButton { primary }

class ButtonWidget extends StatefulWidget {
  final Function()? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final TypeButton type;
  final bool? loading;

  const ButtonWidget({
    super.key,
    this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.type = TypeButton.primary,
    this.loading,
  });

  @override
  State<ButtonWidget> createState() => _ButtonState();
}

class _ButtonState extends State<ButtonWidget> {
  WidgetStatesController statesController = WidgetStatesController();

  @override
  void initState() {
    statesController.addListener(() {
      Future.delayed(Duration.zero, () {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.loading == true ? null : widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(getBackgroundColor),
        padding: WidgetStateProperty.all(widget.padding),
        shape: WidgetStateProperty.all(buttonShape()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.loading == true
              ? const SizedBox(
                  height: 19,
                  width: 19,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  widget.title,
                  style: textStyle(),
                ),
        ],
      ),
    );
  }

  Color getBackgroundColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return AppColors.brandBrown.withOpacity(0.5);
    }
    return AppColors.brandBrown;
  }

  TextStyle textStyle() {
    return TextStyle(
      color: widget.type == TypeButton.primary
          ? AppColors.white
          : AppColors.brandBrown,
      fontWeight: FontWeight.w500,
    );
  }

  RoundedRectangleBorder buttonShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
  }
}
