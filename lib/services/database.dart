import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_weight_app/models/Weight.dart';

class DatabaseService {
  final CollectionReference _weightCollection =
      FirebaseFirestore.instance.collection("weights");

  Future updateWeightItem(double weight, DateTime date, String id) async {
    return await _weightCollection
        .doc(id)
        .set({"weight": weight, "timestamp": Timestamp.fromDate(date)});
  }

  Future addWeightItem(double weight) async {
    return await _weightCollection
        .add({"weight": weight, "timestamp": Timestamp.now()});
  }

  Future deleteWeightItem(String id) {
    return _weightCollection.doc(id).delete();
  }

  List<Weight> _weightListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Weight(
          id: doc.id,
          weight: double.parse(doc.data()["weight"].toString()) ?? 0.0,
          dateTime: doc.data()['timestamp'].toDate());
    }).toList();
  }

  Stream<List<Weight>> get weights {
    return _weightCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(_weightListFromSnapshot);
  }
}
