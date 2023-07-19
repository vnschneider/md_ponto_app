import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileCircleAvatar{
  final BuildContext context;
  final double radius;
  final int image;

  ProfileCircleAvatar({
    required this.context,
    required this.radius,
    required this.image,
  });

  Widget normal() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.background, width: 4),
          borderRadius: BorderRadius.circular(100)),
      // alignment: Alignment.center,

      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SvgPicture.asset(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            semanticsLabel: 'Avatar',
            'assets/avatars/avatar$image.svg',
          ),
        ),
      ),
    );
  }

  Widget small(){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.background, width: 1),
          borderRadius: BorderRadius.circular(100)),
      // alignment: Alignment.center,

      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: SvgPicture.asset(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            semanticsLabel: 'Avatar',
            'assets/avatars/avatar$image.svg',
          ),
        ),
      ),
    );
  }
}


profileCircleAvatar(context, radius, image) {
  
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.background, width: 4),
        borderRadius: BorderRadius.circular(100)),
    // alignment: Alignment.center,

    child: CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SvgPicture.asset(
          alignment: Alignment.center,
          fit: BoxFit.contain,
          semanticsLabel: 'Avatar',
          'assets/avatars/avatar$image.svg',
        ),
      ),
    ),
  );
}

