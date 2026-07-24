import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_mate/viewmodels/user_viewmodel.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 8) {
      return "Rise and Shine";
    } else if (hour >= 8 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 14) {
      return "Good Noon";
    } else if (hour >= 14 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 20) {
      return "Good Evening";
    } else{
      return "Good Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserViewModel>().user;

    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xff6C63FF),
          backgroundImage: user != null && user.imagePath.isNotEmpty
              ? FileImage(File(user.imagePath))
              : null,
          child: user == null || user.imagePath.isEmpty
              ? Text(
            user?.name.isNotEmpty == true
                ? user!.name[0].toUpperCase()
                : "?",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
              : null,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getGreeting(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                user?.name ?? "User",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}