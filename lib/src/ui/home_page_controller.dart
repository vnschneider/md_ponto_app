import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:md_ponto_app/src/data/repositories/md_ponto_app_repository.dart';
import 'package:md_ponto_app/src/data/repositories/models/task_model.dart';
import 'package:md_ponto_app/src/data/repositories/models/user_model.dart';

class HomeController extends GetxController {
  final PontoAppRepository repository;

  final List<UserModel> _userData = <UserModel>[].obs;
  List<UserModel> get userData => _userData;

  final List<TaskModel> _tasksActive = <TaskModel>[].obs;
  List<TaskModel> get tasksActive => _tasksActive;

  final List<TaskModel> _tasksInactive = <TaskModel>[].obs;
  List<TaskModel> get tasksInactive => _tasksInactive;

  final RxBool _userIsLoading = false.obs;
  RxBool get userIsLoading => _userIsLoading;

  final RxBool _taskIsLoading = false.obs;
  RxBool get taskIsLoading => _taskIsLoading;

  HomeController({required this.repository});

  getUser({required String uid}) async {
    _userIsLoading.value = true;

    final response = await repository.getUser(uid);
    _userData.addAll(response as List<UserModel>);

    _userIsLoading.value = false;
  }

  //getActiveTasks
  getActiveTasks() async {
    _taskIsLoading.value = true;

    final response = await repository.getActiveTasks();
    _tasksActive.addAll(response);

    _taskIsLoading.value = false;
  }

  //getInactiveTasks
  getInactiveTasks() async {
    _taskIsLoading.value = true;

    final response = await repository.getInactiveTasks();
    _tasksInactive.addAll(response);

    _taskIsLoading.value = false;
  }
}
