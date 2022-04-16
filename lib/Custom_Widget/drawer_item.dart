import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final bool isSelected;
  const DrawerItem({Key? key,required this.label,required this.icon,required this.onPressed,required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        primary: isSelected ? Colors.purple : Colors.white,
        alignment: Alignment.centerLeft,
        side: BorderSide.none,
        minimumSize: Size(double.maxFinite, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
      ),
    );
  }
}
