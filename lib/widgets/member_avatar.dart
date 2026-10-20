import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../models/models.dart';

const _avatarColors = [
  AppColors.primary,
  AppColors.mint,
  AppColors.amber,
  AppColors.coral,
  Color(0xFFA06CFF),
];

Color avatarColor(String seed) =>
    _avatarColors[seed.hashCode.abs() % _avatarColors.length];

class MemberAvatar extends StatelessWidget {
  final Member member;
  final double size;
  const MemberAvatar({super.key, required this.member, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarColor(member.id),
      ),
      child: Text(
        member.initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.33,
        ),
      ),
    );
  }
}
