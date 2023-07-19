import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:md_ponto_app/src/models/circle_avatar.dart';
import 'package:md_ponto_app/src/models/icon_text_button.dart';
import 'package:md_ponto_app/src/ui/home_page_controller.dart';

import '../data/repositories/md_ponto_app_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final AnimationController _animationController2 = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..addListener(() {
      setState(() {
        expanded.value = _animationController2.value == 1;
        expanded.value = _animationController.value >= 0.5;
      });
    });

  late final HomeController _controller;
  late final List userData;
  late final List tasksActive;
  late final List tasksInactive;
  ValueNotifier expanded = ValueNotifier(false);
  String uid = "cGp1hveEvbQH4fkDlJTSRmY5liG2";

  @override
  void initState() {
    super.initState();

    _controller = HomeController(
      repository: PontoAppRepository(
        dio: Dio(),
      ),
    );

    _controller.getUser(uid: uid);
    userData = _controller.userData;
    _controller.getActiveTasks();
    tasksActive = _controller.tasksActive;
    _controller.getInactiveTasks();
    tasksInactive = _controller.tasksInactive;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.userIsLoading.value
          ? const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              )),
            )
          : _controller.userData.isEmpty
              ? Center(
                  child: Text(
                  "Nenhum usuário encontrado",
                  style: Theme.of(context).textTheme.bodyLarge,
                ))
              : SafeArea(
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(90.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //context / radius / avatar (0 to 9)
                            InkWell(
                              customBorder: const CircleBorder(),
                              overlayColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.tertiary),
                              child: profileCircleAvatar(context, 30.0, 0),
                              onTap: () {},
                            ),

                            const SizedBox(width: 8.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  userData[0].firstName,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                    userData[0].group == 'voluntario'
                                        ? 'Monitor voluntário'
                                        : 'Monitor bolsista',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const SizedBox(height: 2.0),
                                Text(userData[0].email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background
                                                .withOpacity(0.8))),
                              ],
                            ),

                            const Spacer(),
                            IconButton(
                              icon: const Icon(Iconsax.user_search),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8.0),
                            IconButton(
                              style: Theme.of(context).iconButtonTheme.style,
                              icon: const Icon(
                                Iconsax.logout_1,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: body(),
                    ),
                  ),
                ),
    );
  }

  body() {
    return Column(
      children: [
        !expanded.value
            ? SlideTransition(
                position: Tween<Offset>(
                  begin:
                      expanded.value ? const Offset(1, 0) : const Offset(0, 0),
                  end: expanded.value ? const Offset(0, 0) : const Offset(1, 0),
                ).animate(CurvedAnimation(
                    parent: _animationController2,
                    curve: Curves.easeInToLinear)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Em progresso ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text("(${tasksActive.length.toString()})",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: Obx(
                            () => _controller.taskIsLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  )
                                : tasksActive.isEmpty
                                    ? Center(
                                        child: Text(
                                          "Nenhuma atividade em progresso",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      )
                                    : ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 15.0),
                                        itemCount: tasksActive.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final task = tasksActive[index];
                                          return InkWell(
                                            onTap: () {},
                                            child: taskActiveModel(
                                                context, task, userData[0]),
                                          );
                                        },
                                      ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          iconTextButton(context, Iconsax.note_favorite,
                              "Adicionar aula", () {})
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
        !expanded.value ? const Spacer() : const SizedBox(),
        SlideTransition(
          position: Tween<Offset>(
            begin: expanded.value ? const Offset(0, 0.1) : const Offset(0, 0.0),
            end: expanded.value ? const Offset(0, 0.0) : const Offset(0, 0.1),
          ).animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Finalizadas",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        customBorder: const RoundedRectangleBorder(),
                        overlayColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary),
                        highlightColor: Theme.of(context).colorScheme.secondary,
                        onTap: () {
                          setState(() {
                            !expanded.value
                                ? {
                                    _animationController.forward(),
                                    _animationController2.forward(),
                                    expanded.value = !expanded.value,
                                  }
                                : {
                                    _animationController.reverse(),
                                    _animationController2.reverse(),
                                    expanded.value = !expanded.value,
                                  };
                          });
                        },
                        child: Text(
                          expanded.value ? "Ver menos" : "Ver mais",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 6.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: expanded.value
                      ? MediaQuery.of(context).size.height / 1.28
                      : MediaQuery.of(context).size.height * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: "listTasks",
                      transitionOnUserGestures: true,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 20.0);
                        },
                        itemCount: 10,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return taskFinishedModel(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

taskFinishedModel(context) {
  return InkWell(
    onTap: () {},
    overlayColor:
        MaterialStatePropertyAll(Theme.of(context).colorScheme.tertiary),
    splashFactory: InkSplash.splashFactory,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary),
            height: 86,
            width: MediaQuery.of(context).size.width),
        Container(
          width: 8,
          height: 86,
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
        ),
      ],
    ),
  );
}

taskActiveModel(context, task, userData) {
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
                    task.name,
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
                        task.displayLocation,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w100,
                            color: Theme.of(context).colorScheme.background),
                      ),
                      const SizedBox(width: 10.0),
                      Icon(
                        Iconsax.clock,
                        size: 12,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        task.displayStartDate,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w100,
                            color: Theme.of(context).colorScheme.background),
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
                    task.description.toString(),
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
          color: task.users.toString().contains(userData.uid)
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
