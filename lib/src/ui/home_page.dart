import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:md_ponto_app/src/models/circle_avatar.dart';
import 'package:md_ponto_app/src/models/icon_text_button.dart';
import 'package:md_ponto_app/src/models/task_models.dart';
import 'package:md_ponto_app/src/ui/home_page_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data/repositories/md_ponto_app_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  //create page controller
  final _pageController = PageController(
    initialPage: 0,
  );

  late final HomeController _controller;
  late final List userData;
  late final List tasksActive;
  late final List tasksInactive;
  ValueNotifier expanded = ValueNotifier(false);
  String uid = "ACFsy9WA74c81V8pT4iBUF9hjDh2";

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
          : userData.isEmpty
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
                              child: ProfileCircleAvatar(
                                      context: context,
                                      radius: 30,
                                      image: userData[0].photo)
                                  .normal(),
                              onTap: () {},
                            ),

                            const SizedBox(width: 8.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Olá, ${userData[0].firstName} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                        userData[0].group == 'voluntario'
                                            ? 'Monitor voluntário'
                                            : 'Monitor bolsista',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                                // const SizedBox(height: 2.0),
                                Text(userData[0].email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 12,
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
    return Padding(
      padding: const EdgeInsets.only(
          top: 25.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: [
          !expanded.value
              ? SlideTransition(
                  position: Tween<Offset>(
                    begin: expanded.value
                        ? const Offset(1, 0)
                        : const Offset(0, 0),
                    end: expanded.value
                        ? const Offset(0, 0)
                        : const Offset(1, 0),
                  ).animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInToLinear)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Em andamento ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 14),
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
                      const SizedBox(height: 6.0),
                      SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
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
                                          "Nenhuma atividade em andamento",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      )
                                    : PageView.builder(
                                        controller: _pageController,
                                        itemCount: tasksActive.length,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final task = tasksActive[index];
                                          return InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: index ==
                                                      tasksActive.length - 1
                                                  ? const EdgeInsets.only(
                                                      right: 0)
                                                  : const EdgeInsets.only(
                                                      right: 10),
                                              child: TaskModels(
                                                      context: context,
                                                      name: task.name,
                                                      description:
                                                          task.description,
                                                      displayLocation:
                                                          task.displayLocation,
                                                      displayStartDate:
                                                          task.displayStartDate,
                                                      userUID: userData[0].uid,
                                                      taskUsers: task.users)
                                                  .activeTasks(),
                                            ),
                                          );
                                        }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      tasksActive.length > 1
                          ? SmoothPageIndicator(
                              controller: _pageController,
                              count: tasksActive.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                expansionFactor: 2,
                                spacing: 4,
                                dotColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant
                                    .withOpacity(0.4),
                                activeDotColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          IconTextButton(
                            context: context,
                            icon: Iconsax.note_favorite,
                            text: "Adicionar aula",
                            onPressed: () {},
                          ).variant1(),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          !expanded.value ? const Spacer() : const SizedBox(),
          SlideTransition(
            position: Tween<Offset>(
              begin:
                  expanded.value ? const Offset(0, 0.4) : const Offset(0, 0.0),
              end: expanded.value ? const Offset(0, 0.0) : const Offset(0, 0.2),
            ).animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut)),
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragEnd: (_) {
                    if (expanded.value) {
                      _animationController.reverse();
                      setState(() => expanded.value = !expanded.value);
                    }
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Finalizadas",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: 14),
                        ),
                        IconTextButton(
                            context: context,
                            icon: expanded.value
                                ? Iconsax.arrow_down_1
                                : Iconsax.arrow_up_2,
                            text: expanded.value ? "Recolher" : "Expandir",
                            onPressed: () {
                              setState(() {
                                !expanded.value
                                    ? {
                                        _animationController.forward(),
                                        // _animationController2.forward(),
                                        expanded.value = !expanded.value,
                                      }
                                    : {
                                        _animationController.reverse(),
                                        // _animationController2.reverse(),
                                        expanded.value = !expanded.value,
                                      };
                              });
                            }).variant2(),
                      ]),
                ),
                const SizedBox(height: 6.0),
                SizedBox(
                  height: expanded.value
                      ? MediaQuery.of(context).size.height / 1.28
                      : MediaQuery.of(context).size.height * 0.43,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Obx(
                      () => _controller.taskIsLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          : tasksInactive.isEmpty
                              ? Center(
                                  child: Text(
                                    "Nenhuma atividade finalizada",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              : ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 15.0),
                                  itemCount: tasksInactive.length,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final task = tasksInactive[index];
                                    return InkWell(
                                      onTap: () {},
                                      child: TaskModels(
                                              context: context,
                                              name: task.name,
                                              description: task.description,
                                              displayLocation:
                                                  task.displayLocation,
                                              displayStartDate:
                                                  task.displayStartDate,
                                              userUID: userData[0].uid,
                                              taskUsers: task.users)
                                          .inactiveTasks(),
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
