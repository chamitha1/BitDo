import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff0E2B680F).withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1D5DE5),
        unselectedItemColor: const Color(0xff454F63),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xff454F63),
        ),
        elevation: 0,
        items: [
          _navItem(
            "assets/icons/home/home.svg",
            "assets/icons/home/homeSelected.svg",
            "Home",
            0,
          ),
          _navItem(
            "assets/icons/home/p2p.svg",
            "assets/icons/home/p2pSelected.svg",
            "P2P",
            1,
          ),
          // _navItem("assets/icons/home/order.svg", "assets/icons/home/ordersSelected.svg", "Order", 2),
          _navItem(
            "assets/icons/home/profile.svg",
            "assets/icons/home/profileSelected.svg",
            "Profile",
            2,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    String iconPath,
    String selectedIconPath,
    String label,
    int index,
  ) {
    final isSelected = currentIndex == index;

    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff1D5DE5), Color(0xff28A6FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(selectedIconPath, width: 20, height: 20),
            )
          : SvgPicture.asset(iconPath, width: 22, height: 22),
      label: label,
    );
  }
}
