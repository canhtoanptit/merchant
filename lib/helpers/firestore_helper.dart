import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant/models/event_detail_model.dart';
import 'package:merchant/models/favorite_model.dart';

class FireStoreHelper {
  static final Firestore db = Firestore.instance;
  static const String FAVORITES_COLLECTION = 'favourites';

  static Future addFavorite(EventDetail eventDetail, String uid) {
    Favorite favorite = Favorite(null, eventDetail.id, uid);
    var result = db
        .collection(FAVORITES_COLLECTION)
        .add(favorite.toMap())
        .then((value) => print(value.documentID))
        .catchError((error) => print(error));
    return result;
  }

  static Future deleteFavourite(String favId) async {
    await db.collection(FAVORITES_COLLECTION).document(favId).delete();
  }

  static Future<List<Favorite>> getUserFavourites(String uid) async {
    List<Favorite> favs;
    QuerySnapshot docs = await db.collection(FAVORITES_COLLECTION)
    .where('userId', isEqualTo: uid).getDocuments();
    if (docs != null) {
      favs = docs.documents.map((e) => Favorite.map(e)).toList();
    }
    return favs;
  }
}
