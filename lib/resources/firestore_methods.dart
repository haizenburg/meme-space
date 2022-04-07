import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memespace/models/post.dart';
import 'package:memespace/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = "some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: []);

      _firestore.collection('post').doc(postId).set(
            post.toJson(),
          );

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
