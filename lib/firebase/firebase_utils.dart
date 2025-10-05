import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/firebase/task_model.dart';
import 'package:to_do/firebase/user_model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFirestore(snapshot.data()!),
            toFirestore: (task, _) => task.toFirestore());
  }

  // static Future updateTodo(Task todo) async {
  //   return getTaskCollection()
  //       .doc(todo.id)
  //       .update(todo.toFirestore())
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  static Future<void> updetCheack(Task task, String uId) async {
    return getTaskCollection(uId).doc(task.id).update(task.toFirestore());
  }

  static Future<void> addTaskToFirestore(Task task, String uId) {
    var taskCollection = getTaskCollection(uId);
    DocumentReference<Task> taskDocOfRef = taskCollection.doc();
    task.id = taskDocOfRef.id; //auto-generated
    return taskDocOfRef.set(task);
  }

  // static Future<void> updateFromFireBase(Task task) async {
  //   var collection = getTaskCollection();
  //   return await collection.doc(task.id).update({
  //     'id': task.id,
  //     'title': task.title,
  //     'description': task.description,
  //     'dateTime': task.dateTime?.millisecondsSinceEpoch,
  //   });
  // }

  static Future<void> deleteTaskFromFirestore(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  static Future<void> addUserToFirestore(MyUser user) {
    return getUsersCollection().doc(user.uId).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}
