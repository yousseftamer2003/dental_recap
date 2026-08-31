import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_recap/core/networking/apis_strings.dart';
import 'package:dental_recap/features/feed/data/tweet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TweetRepo {
  TweetRepo({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _tweets =>
      _firestore.collection(ApisStrings.tweets);

  String get _uid => _auth.currentUser?.uid ?? '';

  Future<List<TweetModel>> getTweets() async {
    final snapshot = await _tweets
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map(_fromDoc).toList();
  }

  Future<List<TweetModel>> addTweet({
    required String authorName,
    required String authorHandle,
    required String text,
  }) async {
    await _tweets.add({
      'authorId': _uid,
      'authorName': authorName,
      'authorHandle': authorHandle,
      'text': text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'likedBy': <String>[],
    });
    return getTweets();
  }

  Future<List<TweetModel>> toggleLike(String tweetId) async {
    final doc = _tweets.doc(tweetId);
    final snapshot = await doc.get();
    final likedBy = List<String>.from(snapshot.data()?['likedBy'] ?? []);
    final liked = likedBy.contains(_uid);

    await doc.update({
      'likedBy': liked
          ? FieldValue.arrayRemove([_uid])
          : FieldValue.arrayUnion([_uid]),
    });
    return getTweets();
  }

  TweetModel _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final createdAt = data['createdAt'];
    return TweetModel(
      id: doc.id,
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorHandle: data['authorHandle'] ?? '',
      text: data['text'] ?? '',
      createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
      likes: likedBy.length,
      likedByMe: likedBy.contains(_uid),
    );
  }
}
