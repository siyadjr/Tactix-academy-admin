import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Theme/appcolour.dart';
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
        const Text(
          'Welcome Back!!',
          style: TextStyle(
              color: textColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => RequestLists()));
            },
            icon: const Icon(
              Icons.mail,
              color: textColor,
            ))
      ],
    );
  }
}
