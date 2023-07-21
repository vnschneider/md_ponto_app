import 'package:flutter/material.dart';

class IconTextButton {
  final BuildContext context;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  IconTextButton({
    required this.context,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  Widget variant1() {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.0,
            color: Theme.of(context).colorScheme.background,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12, color: Theme.of(context).colorScheme.background),
          ),
        ],
      ),
    );
  }

  Widget variant2() {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.0),
      overlayColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      //highlightColor: ,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.0,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          const SizedBox(width: 2.0),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.surfaceVariant),
          ),
        ],
      ),
    );
  }
}
