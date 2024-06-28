import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticketron/utils/constants.dart';


class BottomSnakeBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;
  const BottomSnakeBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      padding: const EdgeInsets.symmetric(vertical: 20),
      snakeViewColor:Constants.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.withOpacity(0.8),
      currentIndex: selectedIndex,
      onTap: onItemSelected,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            CustomIcons.home,
            height: 20,
            color: selectedIndex == 0
                ? Colors.white
                : Colors.grey.withOpacity(0.8),
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            CustomIcons.search,
            height: 20,
            color: selectedIndex == 1
                ? Colors.white
                : Colors.grey.withOpacity(0.8),
          ),
          label: 'explore',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            CustomIcons.heart,
            color: selectedIndex == 2
                ? Colors.white
                : Colors.grey.withOpacity(0.8),
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            CustomIcons.ticket,
            height: 20,
            color: selectedIndex == 3
                ? Colors.white
                : Colors.grey.withOpacity(0.8),
          ),
          label: 'Ticket',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            CustomIcons.circleUser,
            height: 20,
            color: selectedIndex == 4
                ? Colors.white
                : Colors.grey.withOpacity(0.8),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
