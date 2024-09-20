import 'dart:async';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/route_name.dart';

class NavbarBawah extends StatelessWidget {
  const NavbarBawah({super.key, required this.index, this.delay = 100});

  final int index;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF6243D),
      ),
      child: FluidNavBar(
        icons: [
          FluidNavBarIcon(icon: Icons.home),
          FluidNavBarIcon(icon: Icons.search),
          FluidNavBarIcon(icon: Icons.favorite),
        ],
        defaultIndex: index,
        animationFactor: 1,
        onChange: (int newIndex) {
          Timer(Duration(milliseconds: delay), () {
              try {
                switch (newIndex) {
                  case 0:
                    Get.toNamed(RouteName.home);
                    break;
                  case 1:
                    Get.toNamed(RouteName.search);
                    break;
                  case 2:
                    Get.toNamed(RouteName.favorite);
                    break;
                }
              } catch (e) {
                print('Navigation error: $e');
              }
          });
        },
        style: const FluidNavBarStyle(
          barBackgroundColor: Color(0xFF212121),
          iconBackgroundColor: Color(0xFF212121),
          iconSelectedForegroundColor: Colors.white,
          iconUnselectedForegroundColor: Color(0xFFA6A6A6),
        ),
      ),
    );
  }
}
