import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:md_ponto_app/src/data/repositories/models/user_model.dart';

import 'models/task_model.dart';

class PontoAppRepository {
  final Dio dio;

  PontoAppRepository({required this.dio});

  Future<List<UserModel>> getUsers() async {
    //get api_url from .env
    final result = await dio.get('${dotenv.env['API_URL']}/listUsers');
    final List<UserModel> users = [];
    if (result.statusCode == 200) {
      log(result.data);
      result.data.map((item) => users.add(UserModel.fromMap(item))).toList();
      return users;
    } else {
      throw Exception('Failed to load users list');
    }
  }

  //findUser
  Future<List> getUser(String uid) async {
    //get api_url from .env
    final result = await dio.get('${dotenv.env['API_URL']}/findUser/$uid');
    final List<UserModel> userData = [];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        userData.add(
          UserModel(
            uid: item['uid'],
            firstName: item['firstName'],
            lastName: item['lastName'],
            group: item['group'],
            userType: item['userType'],
            email: item['email'],
            frequence: item['frequence'],
            photo: item['photo'],
          ),
        );
      }
      return userData.toList();
    } else {
      throw Exception('Failed to load user');
    }
  }

  //getAllUserPhotosById
  Future<List> getAllUserPhotosById(List uids) async {
    //para cada uid em uids, chamar a api e retornar a lista de fotos
    final List userPhotos = [];
    for (var uid in uids) {
      final result =
          await dio.get('${dotenv.env['API_URL']}/getUserPhoto/$uid');
      if (result.statusCode == 200) {
        for (var item in result.data) {
          if (!item['photo'].contains('https://')) {
            userPhotos.add('linkDoRepositorioComAsFotos/$item[photo]');
          }
          userPhotos.add(item['photo']);
        }
      }
    }

    return userPhotos.toList();
  }

  //getTasks
  Future<List<TaskModel>> getActiveTasks() async {
    //get api_url from .env
    final result = await dio.get('${dotenv.env['API_URL']}/listTasks');
    final List<TaskModel> tasksActive = [];
    if (result.statusCode == 200) {
      //result add to tasksActive when status = "active"
      for (var item in result.data) {
        if (item['status'] == "active") {
          tasksActive.add(
            TaskModel(
              id: item['_id'],
              name: item['name'],
              description: item['description'],
              group: item['group'],
              location: item['location'],
              displayLocation: item['displayLocation'],
              startDate: item['startDate'],
              displayStartDate: item['displayStartDate'],
              endDate: item['endDate'],
              status: item['status'],
              users: item['users'],
            ),
          );
        }
      }
      return tasksActive.toList();
    } else {
      throw Exception('Failed to load active tasks');
    }
  }

  Future<List<TaskModel>> getInactiveTasks() async {
    //get api_url from .env
    final result = await dio.get('${dotenv.env['API_URL']}/listTasks');
    final List<TaskModel> tasksInactive = [];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        if (item['status'] == "active") {
          tasksInactive.add(
            TaskModel(
              id: item['_id'],
              name: item['name'],
              description: item['description'],
              group: item['group'],
              location: item['location'],
              displayLocation: item['displayLocation'],
              startDate: item['startDate'],
              displayStartDate: item['displayStartDate'],
              endDate: item['endDate'],
              status: item['status'],
              users: item['users'],
            ),
          );
        }
      }
      return tasksInactive.toList();
    } else {
      throw Exception('Failed to load Inactive tasks');
    }
  }

  Future<List<TaskModel>> getScheduledTasks() async {
    //get api_url from .env
    final result = await dio.get('${dotenv.env['API_URL']}/listTasks');
    final List<TaskModel> tasksScheduleds = [];
    if (result.statusCode == 200) {
      for (var item in result.data) {
        if (item['status'] == "active") {
          tasksScheduleds.add(
            TaskModel(
              id: item['_id'],
              name: item['name'],
              description: item['description'],
              group: item['group'],
              location: item['location'],
              displayLocation: item['displayLocation'],
              startDate: item['startDate'],
              displayStartDate: item['displayStartDate'],
              endDate: item['endDate'],
              status: item['status'],
              users: item['users'],
            ),
          );
        }
      }
      return tasksScheduleds.toList();
    } else {
      throw Exception('Failed to load Scheduled tasks');
    }
  }
}
