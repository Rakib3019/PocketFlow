import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import '../../../viewmodels/navigation_viewmodel.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationVM = context.watch<NavigationViewModel>();

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [

          _NavItem(
            index: 0,
            icon: Icons.home_rounded,
            label: "Home",
          ),

          _NavItem(
            index: 1,
            icon: Icons.receipt_long_rounded,
            label: "Transactions",
          ),

          const SizedBox(width: 60),

          _NavItem(
            index: 2,
            icon: Icons.bar_chart_rounded,
            label: "Statistics",
          ),

          _NavItem(
            index: 3,
            icon: Icons.settings_rounded,
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;

  const _NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final navigationVM = context.watch<NavigationViewModel>();

    final bool selected = navigationVM.currentIndex == index;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => navigationVM.changeIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary.withOpacity(.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 24,
                color: selected
                    ? AppColors.secondary
                    : Colors.grey,
              ),

              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: selected
                      ? AppColors.secondary
                      : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}