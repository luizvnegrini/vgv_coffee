import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class NavbarButton extends StatelessWidget {
  final double height;
  final double width;
  final Function()? onTap;
  final IconData icon;
  final Color? color;

  const NavbarButton({
    super.key,
    this.height = 55.0,
    this.width = 40.0,
    this.onTap,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            color: color ?? context.colors.primary,
          ),
        ),
      ),
    );
  }
}
