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
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isWebLayout = constraints.maxWidth > 900;

              return BlocBuilder<HomeScreenDatasBloc, HomeScreenDatasState>(
                builder: (context, state) {
                  if (state is HomeScreenDatasLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: kPrimaryColor),
                    );
                  } else if (state is HomeScreenDatasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              color: kErrorColor, size: 48),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: kTextColorSecondary),
                          ),
                          TextButton(
                            onPressed: () => context
                                .read<HomeScreenDatasBloc>()
                                .add(LoadHomeScreenData()),
                            child: const Text('Retry',
                                style: TextStyle(color: kPrimaryColor)),
                          )
                        ],
                      ),
                    );
                  } else if (state is HomeScreenDatasLoaded) {
                    final homeDetails = state.homeDetails;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Appbar(),
                              const SizedBox(height: 32),
                              if (isWebLayout)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: FeaturesContainer(
                                        details: homeDetails,
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      flex: 2,
                                      child: _buildBrandingCard(constraints),
                                    ),
                                  ],
                                )
                              else ...[
                                _buildBrandingCard(constraints),
                                const SizedBox(height: 32),
                                FeaturesContainer(details: homeDetails),
                              ],
                            ],
                          ),
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
      ),
    );
  }

  Widget _buildBrandingCard(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/boss.png',
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: kPrimaryColor.withOpacity(0.1),
                child: const Icon(Icons.person, color: kPrimaryColor, size: 64),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Academy Management',
            style: TextStyle(
              color: kTextColorPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You are logged in as Administrator',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextColorSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
