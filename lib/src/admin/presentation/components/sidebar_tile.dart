import 'package:flutter/material.dart';

class SideBarTile extends StatelessWidget {
  const SideBarTile({
    Key? key,
    required this.isActive,
    required this.text,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: Icon(
          icon,
          color: isActive ? Theme.of(context).colorScheme.secondary : null,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isActive ? Theme.of(context).colorScheme.secondary : null,
            fontWeight: isActive ? FontWeight.bold : null,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
