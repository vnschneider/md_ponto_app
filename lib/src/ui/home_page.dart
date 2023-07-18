import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:md_ponto_app/src/models/circle_avatar.dart';
import 'package:md_ponto_app/src/models/icon_text_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier expanded = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 40, right: 20.0, left: 20.0, bottom: 10.0),
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
                    'Lorem Ipsum',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Monitor voluntário',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2.0),
                  Text("ID: 000000000",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 10.0, right: 20.0, left: 20.0),
          child: expanded.value ? expandedBody() : body(),
        ),
      ),
    );
  }

  body() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Em progresso ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text("(X)",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceVariant)),
          ],
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10.0);
              },
              itemCount: 3,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return taskActiveModel(context);
              },
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: [
            iconTextButton(
                context, Iconsax.note_favorite, "Adicionar aula", () {})
          ],
        ),
        const Spacer(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Finalizadas",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          InkWell(
            customBorder: const RoundedRectangleBorder(),
            overlayColor:
                MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
            highlightColor: Theme.of(context).colorScheme.secondary,
            onTap: () {
              setState(() {
                expanded.value = true;
              });
            },
            child: Text(
              "Ver mais",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant),
            ),
          ),
        ]),
        const SizedBox(height: 6.0),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: "listTasks",
              transitionOnUserGestures: true,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 24.0);
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
      ],
    );
  }

  expandedBody() {
    return Column(
      children: [
        Row(
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
                  expanded.value = false;
                });
              },
              child: Text(
                "Ver menos",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.surfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.79,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: "listTasks",
              transitionOnUserGestures: true,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 18.0);
                },
                itemCount: 18,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return taskFinishedModel(context);
                },
              ),
            ),
          ),
        ),
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

taskActiveModel(context) {
  return Stack(alignment: Alignment.bottomCenter, children: [
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary),
      height: 180,
      width: MediaQuery.of(context).size.width - 60,
    ),
    Container(
      height: 8,
      width: MediaQuery.of(context).size.width - 60,
      decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    ),
  ]);
}
