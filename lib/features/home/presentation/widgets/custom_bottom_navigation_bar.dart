import 'package:flutter/material.dart';
import 'package:flutter_dev_test/core/routes/router.dart';
import 'package:flutter_dev_test/core/routes/router_names.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';
import 'package:flutter_dev_test/injection.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  void _handleTap(BuildContext context, int index) {
    if (index == 1) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Sair'),
          content: const Text('Deseja encerrar a sessão?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                await storageService.clearSecret();
                router.go(RouterNames.login);
              },
              child: const Text('Sim'),
            ),
          ],
        ),
      );
    } else {
      onIndexChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: kBottomNavigationBarHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8D8C3), Color(0xFFD4B89A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.brandBrown,
          unselectedItemColor: const Color(0xFF6F5E4E),
          selectedLabelStyle: AppTextStyles.heading12.copyWith(
            color: AppColors.brandBrown,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTextStyles.heading12.copyWith(
            color: const Color(0xFF6F5E4E),
          ),
          onTap: (index) => _handleTap(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded, size: 24),
              label: 'Sair',
            ),
          ],
        ),
      ],
    );
  }
}
