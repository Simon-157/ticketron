import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';

class FilterToggles extends StatefulWidget {
  const FilterToggles({super.key});

  @override
  _FilterTogglesState createState() => _FilterTogglesState();
}

class _FilterTogglesState extends State<FilterToggles> {
  int selectedIndex = 0;

  final List<String> filters = ['My feed', 'Concerts', 'Seminar', 'Theater'];

  void _onFilterTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    // Handle filter change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(filters.length, (index) {
        return FilterToggleButton(
          label: filters[index],
          isSelected: index == selectedIndex,
          onTap: () => _onFilterTap(index),
        );
      }),
    );
  }
}

class FilterToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterToggleButton({super.key, 
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.paddingSmall,
          horizontal: Constants.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Constants.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          border: Border.all(
            color: isSelected ? Constants.primaryColor : Constants.borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Constants.textColor,
          ),
        ),
      ),
    );
  }
}
