import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/theme/app_colors.dart';
import 'package:flutter_dev_test/core/theme/text_styles.dart';
import 'package:flutter_dev_test/features/home/bloc/home_bloc.dart';
import 'package:flutter_dev_test/features/home/bloc/home_event.dart';
import 'package:flutter_dev_test/features/home/bloc/home_state.dart';
import 'package:flutter_dev_test/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter_dev_test/injection.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final menuTitles = ['Home', 'Sair'];

    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Text(
              menuTitles[state.index],
              style: AppTextStyles.heading14
                  .copyWith(color: AppColors.secondaryText),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: state.index,
            onIndexChanged: (i) => homeBloc.add(IndexChanged(i)),
          ),
        );
      },
    );
  }
}
