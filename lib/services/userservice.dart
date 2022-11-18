import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/usermodel.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'username': user.username,
        'email': user.email,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    DocumentSnapshot snapshot = await _userReference
        .doc(id)
        .get(); //snapshot adalah object dari firebase cloud firestore, untuk mengambil data dari field berdasarkan id di collection 'users'

    try {
      UserModel user = UserModel(
        id: id,
        username: snapshot[
            'username'], //memanggil field 'name' di id yang ada di collection 'users'
        email: snapshot['email'],
      );

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
