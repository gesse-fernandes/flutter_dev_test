import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';

class OtpWidget extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final void Function(List<TextEditingController>)? onControllersReady;

  const OtpWidget({
    super.key,
    this.onChanged,
    this.onSubmit,
    this.onControllersReady,
  });

  @override
  State<OtpWidget> createState() => _OtpState();
}

class _OtpState extends State<OtpWidget> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void onTextChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    final code = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(code);
    if (code.length == 6) {
      widget.onSubmit?.call(code);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onControllersReady?.call(_controllers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final boxWidth = (constraints.maxWidth - 60) / 6;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 8,
            children: List.generate(6, (index) {
              return SizedBox(
                width: boxWidth < 45 ? 45 : boxWidth,
                height: 52,
                child: Focus(
                  onFocusChange: (_) => setState(() {}),
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    cursorColor: AppColors.brandBrown,
                    style: AppTextStyles.heading16.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandBrown,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: _focusNodes[index].hasFocus
                          ? AppColors.white
                          : AppColors.backgroundSurface,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppColors.backgroundMedium,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppColors.brandBrown,
                          width: 1.5,
                        ),
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (value) => onTextChanged(index, value),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
