import '../db_helper/repository.dart';
import '../model/User.dart';

class Userservice {
  late Repository _repository;

  Userservice() {
    _repository = Repository();
  }

  SaveUser(User user) async {
    return await _repository.insertData('user', user.userMap());
  }

  readAllUsers() async {
    return await _repository.readData('user');
  }

  UpdateUser(User user) async {
    return await _repository.updateData('user', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('user', userId);
  }
}
