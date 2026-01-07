import 'package:BitOwi/features/address_book/data/models/address_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressCard extends StatelessWidget {
  final AddressItem item;
  final VoidCallback? onMoreTap;

  const AddressCard({super.key, required this.item, this.onMoreTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F555555),
            blurRadius: 8,
            spreadRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              // Icon
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF6F9FF),
                ),
                // padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  item.iconPath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF151E2F),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.currencyCode,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF717F9A),
                      ),
                    ),
                  ],
                ),
              ),
              // 3-dot
              GestureDetector(
                onTap: onMoreTap,
                child: SvgPicture.asset(
                  'assets/icons/profile_page/address/dots.svg',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Address Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Address",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF717F9A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.address,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF151E2F),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Copy Button
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: item.address));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Address copied to clipboard'),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/icons/deposit/copy.svg',
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF1D5DE5),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Footer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Added on",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF717F9A),
                ),
              ),
              Text(
                item.date,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF717F9A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
