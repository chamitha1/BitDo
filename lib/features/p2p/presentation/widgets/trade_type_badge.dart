import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TradeTypeBadge extends StatelessWidget {
  final bool isBuy;

  const TradeTypeBadge({super.key, required this.isBuy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isBuy ? const Color(0xFFEAF9F0) : const Color(0xFFFDF4F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isBuy
                ? 'assets/icons/profile_page/arrow-down-left.svg'
                : 'assets/icons/profile_page/arrow-up-right.svg',
            width: 14,
            height: 14,
            colorFilter: ColorFilter.mode(
              isBuy ? const Color(0xFF40A372) : const Color(0xFFE74C3C),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isBuy ? "Buy Ad" : "Sell Ad",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: isBuy ? const Color(0xFF40A372) : const Color(0xFFE74C3C),
            ),
          ),
        ],
      ),
    );
  }
}
