import 'dart:io';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../../../viewmodels/user_viewmodel.dart';

class StatisticsAppBar extends StatelessWidget {
  const StatisticsAppBar({super.key});

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
              const Text(
                "Statistics",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Track your financial activity",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}