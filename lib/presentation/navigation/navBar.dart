import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whos_the_imposter/core/configs/theme/app_colors.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: AppColors.lightBackground,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(() => 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(0, Icons.home),
                    _buildNavItem(1, Icons.search),
                    _buildNavItem(2, Icons.person),
                  ],
                )
              )
            )
          )
        )
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final selectedIndex = 0.obs; // Observable for selected index
    final bool isSelected = index == selectedIndex.value;

    return Obx(() => AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: isSelected
        ? const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightBackground,
        )
      : null,
      padding: isSelected ? const EdgeInsets.all(8) : const EdgeInsets.all(0),
      child: IconButton(
        icon: Icon(
          icon, 
          color: isSelected ? AppColors.primary : AppColors.lightBackground,
        ),
        iconSize: 30.0,
        onPressed: () {
          selectedIndex.value = index; // Update selected index
        },
      ),
    ));
  }
}