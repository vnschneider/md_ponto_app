import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'circle_avatar.dart';

class TaskModels {
  final BuildContext context;
  final String name;
  final String description;
  final String displayLocation;
  final String displayStartDate;
  final List taskUsers;
  final String userUID;

  TaskModels(
      {required this.context,
      required this.name,
      required this.description,
      required this.displayLocation,
      required this.displayStartDate,
      required this.userUID,
      required this.taskUsers});

  Widget activeTasks() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 18, left: 12, right: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.background),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 12,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          displayLocation,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                        const SizedBox(width: 10.0),
                        Icon(
                          Iconsax.clock,
                          size: 12,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          displayStartDate,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                      ],
                    ),
                  ],
                ),
                // const SizedBox(height: 6.0),
                Divider(color: Theme.of(context).colorScheme.background),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Descrição:",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.8)),
                    ),
                    // const SizedBox(height: 4.0),
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time:",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.8))),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileCircleAvatar(
                                    context: context, radius: 10.0, image: 1)
                                .small(),
                            ProfileCircleAvatar(
                                    context: context, radius: 10.0, image: 2)
                                .small(),
                            ProfileCircleAvatar(
                                    context: context, radius: 10.0, image: 3)
                                .small(),
                            ProfileCircleAvatar(
                                    context: context, radius: 10.0, image: 4)
                                .small(),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Progresso:",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.8))),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value: 0.7,
                                color: Theme.of(context).colorScheme.background,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.2),
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "70%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 8,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: taskUsers.toString().contains(userUID)
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

//widget inactiveTasks
  Widget inactiveTasks() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary),
          height: 86,
          width: MediaQuery.of(context).size.width - 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                // const SizedBox(height: 4.0),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.location,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          displayLocation,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Iconsax.clock,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          displayStartDate,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.w100,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileCircleAvatar(
                                context: context, radius: 10.0, image: 1)
                            .small(light: true),
                        ProfileCircleAvatar(
                                context: context, radius: 10.0, image: 2)
                            .small(light: true),
                        ProfileCircleAvatar(
                                context: context, radius: 10.0, image: 3)
                            .small(light: true),
                        ProfileCircleAvatar(
                                context: context, radius: 10.0, image: 4)
                            .small(light: true),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 6,
          height: 86,
          decoration: BoxDecoration(
            color: taskUsers.toString().contains(userUID)
                ? Colors.green
                : Colors.red,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
