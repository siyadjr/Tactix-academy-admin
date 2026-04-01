import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Features/Licence%20Requests/Presentations/Pages/request_lists.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome Back,',
              style: TextStyle(
                color: kTextColorSecondary,
                fontSize: 16,
              ),
            ),
            Text(
              'Administrator',
              style: TextStyle(
                color: kTextColorPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const RequestLists()),
              );
            },
            icon: const Icon(
              Icons.notifications_outlined,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
