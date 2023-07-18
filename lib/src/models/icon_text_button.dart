import 'package:flutter/material.dart';

iconTextButton(context, icon, text, onPressed) {
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
