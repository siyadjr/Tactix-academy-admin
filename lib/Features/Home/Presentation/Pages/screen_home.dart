import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/app_bar.dart';
import 'package:tactix_academy_admin/Features/Home/Presentation/Widgets/feature_container.dart';
import 'package:tactix_academy_admin/Features/Home/presentation/bloc/home_screen_datas_bloc.dart';

final sl = GetIt.instance;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeScreenDatasBloc>()..add(LoadHomeScreenData()),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            bool isWebLayout = constraints.maxWidth > 600;

            return BlocBuilder<HomeScreenDatasBloc, HomeScreenDatasState>(
              builder: (context, state) {
                if (state is HomeScreenDatasLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeScreenDatasError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is HomeScreenDatasLoaded) {
                  final homeDetails = state.homeDetails;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: isWebLayout
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.5,
                                  height: constraints.maxWidth * 0.5,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/boss.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Appbar(),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Boss',
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      FeaturesContainer(
                                        height: constraints.maxWidth * 0.5,
                                        details: homeDetails,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const Appbar(),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Boss',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: constraints.maxWidth * 0.8,
                                  height: constraints.maxWidth * 0.8,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/boss.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                FeaturesContainer(details: homeDetails),
                              ],
                            ),
                    ),
                  );
                }
                return const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}
